The VM didn't restart as expected (step 16), so I technically didn't do the lab entirely but I still passed all the assessments required. I don't see myself using things I've learned in this lab in the future tbh bcs it feels very specific to this scenario.

![alt text](<Cuplikan layar 2025-08-29 190544.png>)

But here some concepts that I learned:

- **VPC** is a virtual network that provides isolation and control over network resources.

  - **Custom Mode VPC**: I created a custom VPC with manually defined subnets, allowing precise control over IP ranges and network segmentation.
  - **Subnets and Zones**: The lab used two subnets across different availability zones to ensure redundancy and high availability. Each subnet has its own IP range and is tied to a specific region/zone.
  - **Why this might be relevant** for me in the future? Understanding VPCs is important for designing secure, scalable cloud architectures, as they control how resources communicate internally and externally.

- **High Availability with Multiple Zones**: Deploying resources (like Domain Controllers) across multiple zones ensures redundancy, minimizing downtime if one zone fails.

  - The lab spreads Domain Controllers across two zones to provide fault tolerance (hence the lab name).
  - This aligns with best practices for high-availability architectures in cloud environments.
  - **Why this might be relevant** for me in the future? High availability is a universal principle for any production system to make sure the system is resilient against failures.

- **Active Directory (AD) Domain Services**: AD is a Microsoft service for managing user authentication, permissions, and network resources in a Windows environment

  - I enabled AD Domain Services on Windows Server instances to create a new domain.
  - Domain Controllers (DCs) manage the AD database, handling authentication and authorization for users and devices.
  - Redundant DCs (one in each subnet/zone) ensure AD services remain available if one DC fails.
  - **Why this might be relevant** for me in the future? Only relevant if I work using Windows-based enterprise environments to manage network systems.

- **Firewall Rules in Cloud Environments**: controls inbound and outbound traffic to VMs, for security obviously
  - I configured firewall rules to allow traffics between subnets.
  - **Lab Notes**: **In a production environment, it's a best practice to secure all the ports that your systems are not actively using and to secure access to your machines using a bastion host.**
  - **Why this might be relevant** for me in the future? If I need to manage cloud security one day
  -
