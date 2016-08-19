
Try {
$transactionScope = New-Object System.Transactions.TransactionScope([System.Transactions.TransactionScopeOption]::RequiresNew)
$connection = New-Object System.Data.SqlClient.SqlConnection
$Server = "DESTSERVER"
$ConnectionString = "Data Source=$server;Initial Catalog=vcac6;Integrated Security=True"
$connection.ConnectionString = $ConnectionString
$Connection.Open()
$command = New-Object System.Data.SqlClient.SqlCommand
$command.Connection = $connection
$command.CommandText = "select * from sys.sysprocesses"
$command.ExecuteNonQuery()	
}
catch [system.exception]
{$message = [String]::Format("The following exception occurred, while executing SQL command. Message: {0}", $_.Exception.Message)
		$stackTrace = [String]::Format("Stack trace: {0}", $_.Exception.StackTrace)
		}

$transactionScope = New-Object System.Transactions.TransactionScope([System.Transactions.TransactionScopeOption]::RequiresNew)
	Try 
	{
		$stopwatch = [Diagnostics.Stopwatch]::StartNew()
		$connection = New-Object System.Data.SqlClient.SqlConnection
		$connection.ConnectionString = $ConnectionString
		$connection.Open()
		$command = New-Object System.Data.SqlClient.SqlCommand
		$command.Connection = $connection
		$command.CommandText = "select * from sys.sysprocesses"

		$connection2 = New-Object System.Data.SqlClient.SqlConnection
		$connection2.ConnectionString = $ConnectionString
		$connection2.Open()
		$result = $command.ExecuteNonQuery()
		$connection.Close()
		$connection2.Close()
		$transactionScope.Complete()
		$durations += $stopwatch.Elapsed.Milliseconds
		$stopwatch.Stop()
		$stopwatch.Reset()
	}
