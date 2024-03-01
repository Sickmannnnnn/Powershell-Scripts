$defaultDirectory = "C:\Users\sat3310\Documents\lab04\data\"                                    #sets the variable defaultDirectory to the location specified
$nounFile = "nouns.txt"                                                                         #sets the variable nounFile to the String specified
$agentNounFile = "agentnouns.txt"                                                               #sets the variable agentNounFile to the String specified
                
$nouns = get-content $defaultdirectory$nounFile                                                 #sets the array nouns to the contents of the file in the default directory at the nouns file
$agentNouns = get-content $defaultDirectory$agentNounFile                                       #sets the array agentNouns to the contents of the file in the default directory at the agent nouns file
$numNouns = $nouns.Count                                                                        #sets the variable numNouns to the length of the nouns array
$numAgent = $agentNouns.Count                                                                   #sets the variable numNouns to the length of the nouns array

$debug = $false                                                                                 #sets the variable debug to false: this is the default value so by default, the user will not debug
$userDebug = Read-Host -Prompt "Would you like to debug? (y/n)"                                 #asks the user using the read-host command if they would like to debug, and puts their response into the string variable userDebug
while($userDebug -ne "y" -and $userDebug -ne "n"){                                              #allows the user to reinput their response until they input a valid response
    Write-Host "$userDebug is not a valid input" -ForegroundColor Red                           #informs the user that their response was invalid
    $userDebug = Read-Host -Prompt "Would you like to debug? (y/n)"                             #takes in their new input through the read host command
    }
if($userDebug -eq "y"){                                                                         #testing whether the user would like to debug by checking if the debug variable is equal to "y"
    $debug = $true                                                                              #setting the debug boolean to true so that the debug methods are entered
    }
        
if($debug -eq $true){                                                                           #On we are debugging by checking if the debug variable is true
    Write-Host "The default directory is at $defaultDirectory"-ForegroundColor Green            #tell the user where the default directory is (The color of the words is changed to green using the foreground command)
    $filesSearch = Get-ChildItem -Path $defaultDirectory -File                                  #puts all of the files that are in default directory into the array filesSearch
    Write-Host "The files in the default directory are: "                                       #Informs the user where the files are being printed from
    foreach ($file in $filesSearch){                                                            #loops through all of the files in the filesSearch array
        Write-Host $file.Name                                                                   #Prints out the name of the file
        }
    Write-Host "The nouns file is at $nounFile"-ForegroundColor Green                           #tell the user where the nouns file is getting its data
    Write-Host "The agent nouns file is at $agentNounFile"-ForegroundColor Green                #tell the user where the agent nouns file is getting its data
    $inspectFiles = Read-Host -Prompt "Would you like to inspect the inputted files? (y/n)"     #ask the user if they would like to inspect the contents of the two arrays from the noun file and the agent noun file, and set that string to the variable inspectFiles
    while($inspectFiles -ne "y" -and $inspectFiles -ne "n"){                                    #allows the user to reinput their response until they input a valid response
        Write-Host "$userDebug is not a valid input" -ForegroundColor Red                       #inform the user that their input is not valid and tell them what their input was
        $inspectFiles = Read-Host -Prompt "Would you like to debug? (y/n)"                      #ask the question again and allow the user to reinput
        }
    if($inspectFiles -eq "y"){                                                                  #check if we will inspect the files by checking if the boolean inspectFiles was set to true in the previous code segment
        Write-Host "The nouns file contains the values:"-ForegroundColor Green                  #inform the user what array is being printed
        Write-Host "$nouns"-ForegroundColor Green                                               #prints the contents of the nouns array
        Write-Host "The agent nouns file contains the values:"-ForegroundColor Green            #inform the user what array is being printed
        Write-Host "$agentNouns" -ForegroundColor Green                                         #prints the contents of the agent nouns array
        }
    }

if($numNouns -ne 0){                                                                            #checks if the nouns array is empty using the variable numNouns set earlier
    Write-Host "There are $numNouns in $nounFile"                                               #prints out the length of the array
    }
else{
    throw "The nouns array is empty"                                                            #Throws an error so that we do not take a random variable out of an empty array
    }
if($numAgent -ne 0){                                                                            #checks if the agent nouns array is empty using the variable numAgent set earlier
    Write-Host "There are $numAgent in $agentNounFile"                                          #prints out the length of the array
    }
else{
    throw "The nouns array is empty"                                                            #Throws an error so that we do not take a random variable out of an empty array
    }

$randomNoun=$nouns | Get-Random                                                                 #Selects a random variable out of the nouns array using the get-random command, and sets that string to the variable randomNoun
$randomAgent=$agentNouns | Get-Random                                                           ##Selects a random variable out of the nouns array using the get-random command, and sets that string to the variable randomAgentNoun
write-host "I am studying to become a $randomNoun $randomAgent when I graduate" -ForegroundColor Black -BackgroundColor White          
 #Tells the user what random noun and random agent noun was chosen, and sets both the backgroudn color and foreground color using their respective commands