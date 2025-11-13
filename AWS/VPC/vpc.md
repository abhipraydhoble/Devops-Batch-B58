# VPC - Virtual Private Network

## **Create VPC**
1. Navigate to the **VPC Dashboard** in AWS Management Console.
2. Click on **"Your VPCs"** > **"Create VPC"**.
3. Provide the following details:
   - **Name Tag**: `My-VPC`
   - **IPv4 CIDR Block**: `192.168.0.0/16`
   - **IPv6 CIDR Block**: Optional (leave blank unless needed).
   - **Tenancy**: `Default`.
4. Click **Create VPC**.

---

## **Subnet-Hosts-Range Calculations**
| **Subnet CIDR Block** | **Total IPs** | **Usable IPs** | **Subnet Mask**       |
|------------------------|---------------|----------------|-----------------------|
| `192.168.0.0/22`      | 1,024         | 1,022          | `255.255.252.0`       |

---

## **Create Public Subnet**
1. Navigate to **Subnets** in the VPC Dashboard.
2. Click **Create Subnet**.
3. Fill in the following details:
   - **Name Tag**: `Public-Subnet`.
   - **VPC**: Select `My-VPC`.
   - **Availability Zone**: Choose an AZ (e.g., `us-east-1a`).
   - **IPv4 CIDR Block**: `192.168.0.0/22`.
4. Click **Create Subnet**.

---

## **Create Private Subnet**
1. Follow the same process as **Public Subnet** creation.
2. Change the **Name Tag** to `Private-Subnet`.
3. Use the **IPv4 CIDR Block**: `192.168.4.0/22`.

---

## **Create Internet Gateway**
1. Go to **Internet Gateways** in the VPC Dashboard.
2. Click **Create Internet Gateway**.
3. Provide a **Name Tag**: `My-Internet-Gateway`.
4. Click **Create Internet Gateway**.
5. Attach the Internet Gateway to the VPC:
   - Select the Internet Gateway > Actions > Attach to VPC.
   - Choose `My-VPC` and click **Attach**.

---

## **Create Route Tables**
### **Public Route Table**
1. Navigate to **Route Tables** in the VPC Dashboard.
2. Click **Create Route Table**.
3. Provide the following details:
   - **Name Tag**: `Public-Route-Table`.
   - **VPC**: Select `My-VPC`.
4. Add a Route:
   - **Destination**: `0.0.0.0/0`.
   - **Target**: Select the Internet Gateway (`My-Internet-Gateway`).
5. Click **Save Routes**.
6. Associate the Route Table with the Public Subnet:
   - Select `Public-Subnet` and click **Save**.

---

### **Private Route Table**
1. Repeat the process to create another route table:
   - **Name Tag**: `Private-Route-Table`.
   - **VPC**: Select `My-VPC`.
2. Associate the Route Table with the Private Subnet:
   - Select `Private-Subnet` and click **Save**.

---

## **Launch Instances**
### **Launch Public Instance**
1. Go to **EC2 Dashboard** > **Launch Instance**.
2. Configure the instance:
   - **Subnet**: Select `Public-Subnet`.
   - **Auto-assign Public IP**: Enable.
3. Complete the rest of the configuration and launch the instance.

---

### **Launch Private Instance**
1. Go to **EC2 Dashboard** > **Launch Instance**.
2. Configure the instance:
   - **Subnet**: Select `Private-Subnet`.
   - **Auto-assign Public IP**: Disable.
3. Complete the rest of the configuration and launch the instance.

---

## **Connect Instances**
1. **SSH into the Public Instance** using your key pair.
2. From the Public Instance, SSH into the Private Instance:
   - Copy the private key to the public instance using `scp`.
   - Use the private key to connect to the private instance.
