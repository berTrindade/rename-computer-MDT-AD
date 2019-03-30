$names = Get-ADComputer -Filter * -SearchBase "CN = Computers, DC = lab, DC = ecxglobal, DC = local" | Where-Object {$_.Name -match '^D\d+$'} | Select-Object -ExpandProperty Name | Sort-Object 

$num = $names -replace '\D+'

function Get-FirstFree($array)
{
    $free = 0;

    for($i = 0; $i -le $array.Count; $i++)
    {
        if(($array[$i+1] - $array[$i]) -gt 1)
        {
             $free = 'D{0:000}' -f ([int]$array[$i] + 1);   
             break;     
        } 
    }


    if($free -eq 0)
    {
        $free = 'D{0:000}' -f ([int]$array[$array.Count - 1] + 1);        
    }

    return $free
}

$result = Get-FirstFree $num

# Create an object to access the task sequence environment
$tsenv = New-Object -ComObject Microsoft.SMS.TSEnvironment

$tsenv:OSDComputerName = “$result”
