cmd='mcs '

for file in *.cs
   do
      cmd="$cmd $file"
   done
cmd="$cmd -out:Program.exe"
echo $cmd
$eval $cmd

