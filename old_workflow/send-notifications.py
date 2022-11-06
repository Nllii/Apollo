
import smtplib
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText
import toml 
from pathlib import Path
credentials = toml.load(Path().absolute()/'workflow-settings.toml')




id_= credentials['email']
def sendmail(message):
    msg = MIMEMultipart()
    msg['From'] = id_['from']
    msg['To'] = id_['to']
    msg['Subject'] = id_['subject']
    message = str(''.join(message))
    msg.attach(MIMEText(message))
    mailserver = smtplib.SMTP('smtp.mail.me.com', 587)
    # identify ourselves
    mailserver.ehlo()
    # secure our email with tls encryption
    mailserver.starttls()
    # re-identify ourselves as an encrypted connection
    mailserver.ehlo()
    mailserver.login(id_['from'], id_['password'])
    mailserver.sendmail(id_['from'],
                        id_['to'], msg.as_bytes())

    mailserver.quit()
    

# open a text file called "myfile.txt" 
with open("/tmp/is_online.txt", "r") as text_file:
    status_ = text_file.read()
    sendmail(str(status_))
    text_file.close()
