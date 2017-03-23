require 'aws-sdk'

def display_addresses(ec2Client, instance_id)
  describe_addresses_result = ec2Client.describe_addresses({
    filters: [
      {
        name: "instance-id",
        values: [ instance_id ]
      },
    ]
  })
  if describe_addresses_result.addresses.count == 0
    puts "  No public addresses currently associated with the instance."
  else
    describe_addresses_result.addresses.each do |address|
      # puts "  Allocation ID: #{address.allocation_id}"
      # puts "  Association ID: #{address.association_id}"
      # puts "  Instance ID: #{address.instance_id}"
      puts "  Pub IP: #{address.public_ip}"
    end
  end
end

def display_inbound_ports(security_groups)
  portHash = Hash.new
  security_groups.each do |secGroup|
    awsIPPerms = Aws::EC2::SecurityGroup.new(secGroup.group_id)
	
	awsIPPerms.ip_permissions.each do |ipPerms|
	  # Make room in the Hash
	  ipProtocol = ipPerms["ip_protocol"]
	  if (portHash[ipProtocol].nil?) 
	    portHash[ipProtocol] = []
      end
	  
	  # Grab the ports
	  fromPort = ipPerms["from_port"].to_i
	  toPort = ipPerms["to_port"].to_i
	  (fromPort..toPort).each do |port|
	    portHash[ipProtocol].push(port)
	  end
	end
  end
  portHash.keys.each do |hashKey|
    puts "  Inbound-#{hashKey}: #{portHash[hashKey].uniq.sort}"
  end
end

# Hard-coded, make overridable via cmd line input
region = 'us-east-1'
ec2 = Aws::EC2::Resource.new(region: region)
ec2Client = Aws::EC2::Client.new(region: region)

puts "...Querying AWS #{region}"
puts "="*20
      
# Iterate over all EC2 instances.  (Don't use if you have a lot)
nonDesiredStates = ["stopped","terminated"]
ec2.instances.each do |inst|
  if ( !nonDesiredStates.include?(inst.state.name) )
    name = "(no tag name)"
	inst.tags.each do |tag|
	  if (tag.key=="Name")
	    # Capture tag Name
	    name = tag.value
	  end
	end
	# How do we get an instance's OS?  instance_type doesn't work...
	puts "#{name}   status:#{inst.state.name}   #{inst.instance_type}  #{inst.platform}   id:#{inst.id}   vpc:#{inst.vpc_id}"
	puts "  Prv IP: #{inst.private_ip_address}"
	
	display_addresses(ec2Client, inst.id)
	display_inbound_ports(inst.security_groups)
	
	puts "="*20
  end
end

