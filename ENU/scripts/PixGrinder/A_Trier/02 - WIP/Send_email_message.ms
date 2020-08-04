
-- ref : http://josbalcaen.com/send-mail-with-attachment-maxscript/ --


MailMessage = dotNetObject "System.Net.Mail.MailMessage"
MailAdressFrom = dotNetObject "System.Net.Mail.MailAddress" FromAdress
MailMessage.From = MailAdressFrom
MailAdressTo = dotNetObject "System.Net.Mail.MailAddress" ToAdress
MailMessage.To.Add MailAdressTo
MailMessage.Subject = Subject
MailMessage.Body = Text