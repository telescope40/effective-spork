#Louis DeVictoria
import requests
import ipaddress


def get_publicip():
	ipGet = requests.get("https://api.ipify.org")
	ip = ipGet.text.strip()
	result = (f"node_ip: {ip}")
	if ipaddress.ip_address(ip).is_global == True:
		with open('./performance.yml',"a+") as info:
			info.writelines(result)
		return(ip)
	else:
		raise Exception


if __name__ == "__main__":
	get_publicip()
