## START AND STOP EC2 INSTANCES USING LAMBDA FUNCTION

### Step 1: Create one Linux instance. 
### Step 2: Open the IAM service and create a role to access lambda services. 
**Steps:**

• Select AWS services 

• Choose lambda use case. 

• Click on permission and use two policies: AWSLambdaBasicExecutionRole (allow to use cloudwatch) and AmazonEC2Full Access. 

![image](https://github.com/user-attachments/assets/dfc824ac-8ff3-4a1a-af9c-5965522cbd98)



   - Note: You can create your policies, or you can select existing policies
 
• Provide a tag.

• Provide Role name and role description. 

### Step 3: Open Lambda services and create a new lambda function. 

**Steps:**

• Provide function name. 

• Use Python as a runtime environment. 

• Go to permissions and use the created role in Step 2. 

• Now basic function code window will appear, and we need to write code for starting and stopping EC2 instances. 
 

## start ec2
````
import boto3

# Initialize the EC2 client
ec2 = boto3.client('ec2')

def lambda_handler(event, context):
    # Hardcoded EC2 instance ID
    instance_id = 'i-0a30a69aab79a1275'
    
    # Start the EC2 instance
    try:
        response = ec2.start_instances(InstanceIds=[instance_id])
        print(f'Starting instance {instance_id}')
        return f'Instance {instance_id} is starting'
    
    except Exception as e:
        print(f'Error starting instance {instance_id}: {str(e)}')
        return f'Error: {str(e)}'
````

````
{
    "action": "start"
}
````

## stop ec2
````
import boto3

# Initialize the EC2 client
ec2 = boto3.client('ec2')

def lambda_handler(event, context):
    # Hardcoded EC2 instance ID
    instance_id = 'i-0a30a69aab79a1275'
    
    # Stop the EC2 instance
    try:
        response = ec2.stop_instances(InstanceIds=[instance_id])
        print(f'Stopping instance {instance_id}')
        return f'Instance {instance_id} is stopping'
    
    except Exception as e:
        print(f'Error stopping instance {instance_id}: {str(e)}')
        return f'Error: {str(e)}'

````
````
{
    "action": "stop"
}
````

![image](https://github.com/user-attachments/assets/7f126e21-c83b-452d-a810-3a6470ce5102)



![image](https://github.com/user-attachments/assets/596e1207-fe0b-4dfb-8538-719c565a329c)
