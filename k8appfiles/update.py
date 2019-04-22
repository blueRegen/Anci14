import yaml
import sys
with open('./k8appfiles/frontendDeployment.yml') as f:
        doc = yaml.load(f)

#doc['metadata'] = {'name': 'frontend','namespace': 'kube-system', 'BuildId':sys.argv[1]}
doc['spec']['template']['spec']['containers'][0]['image'] = '342347373179.dkr.ecr.us-east-1.amazonaws.com/docker-php-symfony-angular_node:'+sys.argv[1]

with open('./k8appfiles/frontendDeployment.yml', 'w') as f:
        yaml.dump(doc, f)
