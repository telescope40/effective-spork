#Louis DeVictoria
#Python Script to load the dictionary file and jinja2 template to create a configuration
#! /usr/bin/python3

from jinja2  import Environment, FileSystemLoader , StrictUndefined
#Local Directory
file_loader = FileSystemLoader('./')
#Load Environment
env = Environment(loader=file_loader)
import yaml
template = env.get_template('./prometheus.j2')

def render_cfg():
    with open('./performance.yml') as info2:
        device_dict = yaml.load(info2, Loader=yaml.FullLoader)
        #Opens the host device dictionary and pulls the values
        hostname = (device_dict['systemname'])
        #This will take the hostfile file variables and run through the jinja2 file and output a yaml file
        config_yaml = template.render(device_dict, undefined=StrictUndefined)
        #Create the leaf yaml file
        #leaf_file = hostname+".yml"
        #print(leaf_file)

    with open("./prometheus/prometheus.yml", 'a+') as config:
        config.write(config_yaml)
        config.close()

    #Print the output
        print(config)

if __name__ == '__main__':
    render_cfg()
