# Cloudflare-DynamicDNS
Don't like noip renewal every Month ? Just run this bash script and you have a fully functional Dynamic DNS in with CloudFlare 

### Prerequisites
* A CloudFlare Account With a valid domain name configured in the account
* Cloudflare Login email id
* Cloudflare Global API key, get it from https://www.cloudflare.com/a/account/my-account
* Your Domain name (Website name in Cloudfalre)
* A Record to be used as Dynamic DNS, Eg: ddns , and your DynamicDNS will be ddns.example.com

### How to use the script
* Download the script to the home directory.
<pre>cd ~ && wget https://raw.githubusercontent.com/redhatjobin/Cloudflare-DynamicDNS/master/Cloudflare-DynamicDNS.sh && chmod +x Cloudflare-DynamicDNS.sh </pre>
* edit Cloudflare-DynamicDNS.sh and replace these variables in the script

<pre>cf_email=your-login-id@gmail.com   # Your Login email id
api_key=XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX # Get this from CloudFlare MySettings > Global API key Section
zone_name=example.com   # Your Website name in CloudFlare eg: example.com
record_name=ddns           # A record name for DynamicDNS eg: ddns</pre>
* Now add the below cron
<pre> */5 * * * * ~/Cloudflare-DynamicDNS.sh</pre>


