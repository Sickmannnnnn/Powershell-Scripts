#Variables
$datafile = "fortune500.tsv"                                        #variable datafile will hold the file handle string
$dataurl = "http://pages.mtu.edu/~toarney/sat3310/lab07/"           #Variable dataurl will hold the url string to the file that we need to collect
$datapath = "C:\Users\zacks\OneDrive\Documents\Data\"               #Variable datapath will hold the file path string to the directory where we are storing the file
$count = 0                                                          #Variable count will hold the number of servers we have contacted (successfully or not)
$servertypes = @()                                                  #Variable servertypes will contain the server types of every server we have contacted
$sites = Import-CSV -Path $datapath$datafile -Delimiter "`t"        #Using the Import-CSV command, we create an empty csv file in the directory specified by the datapath called the string in datafile. This CSV file is delimited by a tab. It is then put into the variable sites.
$numberofwebsites = $sites.Length                                   #Variable numberofwebsites holds the length of the sites variable, which represents the number of websites on the file
$debug = $false                                                      #Determines if the would like to debug, which allows it to perform basic functin 

if($debug){                                                         #Check if we are debugging
    if($numberofwebsites > 0){                                      #Check if the length of sites is greater than 0 to determine if it has already been written to
        Write-Host "The file at $dataurl$datafile has already been written to $datapath$datafile"
    }
    Write-Host $sites                                               
}

#download
Invoke-WebRequest -Uri $dataurl$datafile -OutFile $datapath$datafile      #Download the file at the url given in the Uri argument and write it to the file at the filepath in the OutFile argument

Write-Host "There are $numberofwebsites in $datapath$datafile"            #Print out to the screen the number of websites and in what file

foreach ($website in $sites)                                              #Parses through each dictionary in the sites variable
{
    $count++                                                              #Increment the count of servers accessed
    $uri = $website.Website                                               #Varible uri will hold the url to the website from the Website key in the website variable
    Write-Progress -Activity "Working... $count of $numberofwebsites." -Status "Percent complete $(($count/$numberofwebsites)*100)%" -PercentComplete (($count/$numberofwebsites)*100) 
                                                                          #In the Write-Progress cmdlet, the arguments are simply boxes that can hold information thatwe have to calculate ourselves
                                                                          #The Activity argument holds the number of websites accessed and the total number of websites
                                                                          #The Status argument holds the percentage complete which is calculated by dividing the number of websites accessed by the total number of websites
                                                                          #The PercentComplete argument holds the same percentage completed, but displays it as a progress bar
    $webrequest = Invoke-Webrequest -Uri $uri -Timeout 1     #Using the Invoke-Webrequest cmdlet, we will access the webserver at the url in variable uri. We only attempt to contact each webserver for 1 second using the Timeout argument. 
    if ($webrequest.Headers.Server)                          #Access the Server variable from the headers attribute of the webrequest and check if it exists
    {
        $servertypes+=$webrequest.Headers.Server             #If it exists, append it to our array
    }
    else
    {
        $servertypes+="unknown"                              #If it doesn't exist, append the string "unknown" to our array
    }
}    
$servertypes | Group-Object | Sort-Object count | Select-Object name,count
                                                             #Taking the array that we stored the server types to, we pipe that into the Group-Object cmdlet
                                                             #Using Group-Object, we keep only unique strings, but count how many of each there is. This is then piped into Sort-Object
                                                             #Using Sort-Object, we sort each object in our new dictionary by its frequency in the original array. This is then piped into Select-Object
                                                             #Using Select-Object, we print out the name (server type) and the count