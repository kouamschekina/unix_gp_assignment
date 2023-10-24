  #task1
system_inspection_and_report(){
  echo "uname: "
  uname > name.txt 
  lsb_release -a > lsb.txt
  echo "Running processes: "
  ps aux | head -n 20 > processes.txt
  cat processes.txt
  echo "" 

  echo "Disk usage: "
  df -h | sort -hr | head -n 20 > disk.txt
  cat disk.txt
  echo ""

  echo "Network Connections: "
  netstat | head -n 20 > network.txt
  cat network.txt
  echo ""

  echo "System report: " #creating a  summary of the above findings
  cat name.txt >> report.txt
  cat lsb.txt >> report.txt
  cat processes.txt >> report.txt
  cat disk.txt >> report.txt
  cat network.txt >> report.txt
  cat report.txt
 
echo " End of system inspection and report "
}

  #task 2
file_operation(){
 extension(){
  read -p "Enter the directory path: " directory
  read -p "Enter the file extension: " extension 
   
  find "$directory" -type f -name "*.$extension"
 }
 counts(){
  read -p "Enter the directory of the file: " directory
  read -p "Enter the name of the file: " file
  ls | grep '$extension'
  if [[ -f "$directory/$file" ]]; then 
   count=$(wc -l < "$directory/$file")  #counting the number of lines from the chosen file
   echo "Number of lines in $file: $count"
  else
   echo "File not found"
 fi
 }
 backup(){
  read -p "Enter the directory path: " directory
  read -p "Enter the name of the file: " file
  tar cfz backup.xz $directory/$file
  cat backup.xz 
 } 
 extension
 counts
 backup
} 

  #task 3
Data_fetching(){
   read -p "Enter a city: " city
   API_KEY="1a2720c6bcmshd7743da4d4e62e8p192ef8jsn92530feb5d17"
   url="https://weatherapi-com.p.rapidapi.com/current.json?q=${city}&key=${API_KEY}"
   response=$(curl -s -H "X-RapidAPI-Host: weatherapi-com.p.rapidapi.com" -H "X-RapidAPI-Key: ${API_KEY}" $url)  
 #check if the API request was successful
  if [[ $(echo $response | jq -r '.error') == null ]]; then
	location=$(echo $response | jq -r '.location.name')
  	region=$(echo $response | jq -r '.location.region')
  	country=$(echo $response | jq -r '.location.country')
  	weather=$(echo $response | jq -r '.current.condition.text')
  	temperature=$(echo $response | jq -r '.current.temp_c')
  	echo "The current weather in ${location}, ${region}, ${country} is ${weather} with a temperature of ${temperature}°C."
   else
  	echo "Unable to fetch weather data. Please try again later."
   fi
  
} 

echo " Hey hope you are doing great!! "
echo " Below is our list of tasks. Please make your choice."
echo "1 for System inspection and Report." 
echo "2 for File Operations."
echo "3 Data fetching."
echo "4 for exit"

read -p "Enter your choice: " choice

case $choice in
  1)
   system_inspection_and_report
   
   ;;

  2)
   file_operation
   
   ;;

  3)
   Data_fetching
 
   ;;

  4)
   echo "Exiting..."
   exit 0
   ;;

  *)
   echo "Invalid choice. Please try again."
   ;;

esac
