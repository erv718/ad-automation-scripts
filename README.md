# AD Automation Scripts

With 100+ club locations, manually assigning workstations to the right security groups and OUs in Active Directory was not sustainable. Every new workstation had to be matched to its club number, placed in the correct OU, and added to the right security groups for GPO targeting.

## What These Scripts Do

- **set_club_workstation_securitygroups_and_ou.ps1** - Reads all computer objects from the Clubs OU, extracts the club number from the hostname, and assigns each workstation to the matching security groups (FRD, FD, KIOSK, BO designations). Also moves workstations to the correct club OU based on a CSV mapping.
- **set_club_workstation_securitygroups_and_ou_default_computers.ps1** - Same logic but targets workstations sitting in the default Computers container that haven't been sorted yet.
- **Windows 11 Devices.ps1** - Identifies Windows 11 workstations across the domain.
- **Move Users.ps1 / Move Computers.ps1** - Bulk-moves AD objects to new OU structures using CSV input.
- **AD_Remove_Disabled_Users_From_Groups.ps1** - Strips group memberships from disabled user accounts.
- **SecurityGroup.ps1** - Security group management utility.

## Usage

```powershell
# Run the main workstation assignment script on the domain controller
.\set_club_workstation_securitygroups_and_ou.ps1

# Move users/computers to new OUs using CSV input
.\Move Users.ps1
.\Move Computers.ps1
```

The CSV files (`example-club-ous-computers.csv`, `example-club-ous-users.csv`) show the expected format for OU mapping input.

## Requirements

- PowerShell 5.1+
- `ActiveDirectory` module (RSAT)
- Domain admin or delegated OU/group management permissions
- Run from a domain controller or workstation with AD tools installed

## Blog Post

[Automating AD Security Group Assignment Across 100+ Sites](https://blog.soarsystems.cc/active-directory-automation-scripts/)
