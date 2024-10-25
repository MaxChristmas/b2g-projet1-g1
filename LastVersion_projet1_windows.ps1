
#!/usr/bin/env powershell

# create_user, delete_user, last_login_user, shutdown_computer, reboot_computer, os_version are 
# functions that perform specific actions using SSH to interact with the remote machine.

# Definition of variables 
$User = $env:USERNAME  

# Variables for SSH connection (ensure these Variables are set correctly)
$TargetUser = "ahmedWindows"
$TargetIP = "192.168.128.144"

# Functions to be used

function create_user {
    Write-Host " Creating a User "
    $new_user = Read-Host " Name of the new user "
    $password = Read-Host " password "
    # Use SSH to create the user on the remote machine
   $sshCommand = "ssh $TargetUser@$TargetIP net user $new_user $password /add /active:yes"
    Invoke-Expression $sshCommand

    if ($LASTEXITCODE -eq 0) {
        Write-Host "User $new_user created successfully."
    } else {
        Write-Host "Error executing the command"
    }

    Read-Host "Press any key to return to the main menu..."
    main_menu
}

function delete_user {
    Write-Host " Deleting a User: "
    $del_user = Read-Host " Name of the user to delete "

    # Use SSH to delete the user on the remote machine
    $sshCommand = "ssh $TargetUser@$TargetIP net user $del_user /delete"
    Invoke-Expression $sshCommand

    if ($LASTEXITCODE -eq 0) {
        Write-Host "User $del_user deleted successfully."
    } else {
        Write-Host "Error executing the command"
    }

    Read-Host "Press any key to return to the main menu..."
    main_menu
}



function shutdown_computer {
    Write-Host " Shutdown the Computer: "

    # Use SSH to shutdown the remote machine
    $sshCommand = "ssh $TargetUser@$TargetIP shutdown /s /t 0"
    Invoke-Expression $sshCommand

    if ($LASTEXITCODE -eq 0) {
        Write-Host "The machine $TargetIP is shutting down."
    } else {
        Write-Host "Error during shutdown..."
    }

    Read-Host "Press any key to return to the main menu..."
    main_menu
}

function reboot_computer {
    Write-Host "Reboot the Computer:"

    # Use SSH to reboot the remote machine
    $sshCommand = "ssh $TargetUser@$TargetIP shutdown /r /t 0"
    Invoke-Expression $sshCommand

    if ($LASTEXITCODE -eq 0) {
        Write-Host "The machine $TargetIP is rebooting."
    } else {
        Write-Host "Error during reboot..."
    }

    Read-Host "Press any key to return to the main menu..."
    main_menu
}

function os_version {
    Write-Host "Get the OS Version:"

    # Use SSH to get the OS version of the remote machine
    $command = "wmic os get Caption,Version"
    $sshCommand = "ssh $TargetUser@$TargetIP '$command' "  
    $version = Invoke-Expression $sshCommand
     # Check if the command was successful
    if ($LASTEXITCODE -ne 0) {
        Write-Host "Failed to retrieve OS version."
        return
    }
    # Check the exit code after running the SSH command

        Write-Host "OS Version: $version"


    # Get the current date in YYYYMMDD format
    $CurrentDate = Get-Date -Format "yyyyMMdd"

    # Save the OS version to a file
    $outputFile = "$env:USERPROFILE\Documents\info_OS_$TargetIP_$CurrentDate.txt"
    $version | Out-File -FilePath $outputFile -Encoding UTF8
    Write-Host "OS version saved to: $outputFile"

    Read-Host "Press any key to return to the main menu..."
    main_menu
}

function main_menu {

    Write-Host "==== Main Menu ===="
    Write-Host " * Manage Users * "
    Write-Host " ----------------- "
    Write-Host " 1. Create User"
    Write-Host " 2. Delete User"
    Write-Host
    Write-Host " --------------------- "
    Write-Host " 3. Shutdown Computer"
    Write-Host " 4. Reboot Computer"
    Write-Host " 5. Get OS Version"
    Write-Host " 6. Exit"

    $choice = Read-Host "Choose an option"
    switch ($choice) {
        1 { create_user }
        2 { delete_user }
        3 { shutdown_computer }
        4 { reboot_computer }
        5 { os_version }
        6 { exit }
        default { 
		"Invalid choice."
	 	main_menu 
	}
    }
}

main_menu
