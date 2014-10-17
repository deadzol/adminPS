import-module activedirectory
$locked = search-adaccount -lockedout|select name,lastlogondate

if ($locked -ne $null ){
	foreach ($account in $locked){
		#write-host $account.name " " $account.lastlogondate
		$lockedMsg += $account.name + "`t" + $account.lastlogondate + "`r`n"
	}
	write-host $lockedMsg
	$smtpServer = "<smtp server>"
	$msg = new-object Net.Mail.MailMessage
	$smtp = new-object Net.Mail.SmtpClient($smtpServer)
	$msg.From = "<email addr>"
	$msg.ReplyTo = "<email addr>"
	$msg.To.Add("<email addr>")
	$msg.subject = "Locked users"
	$msg.body = $lockedMsg
	$smtp.Send($msg)
}
