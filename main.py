import argparse,sys
from module import build,public

parser=argparse.ArgumentParser(description='deploys duang!!!')

parser.add_argument(dest='pro_name',type=str)
parser.add_argument(dest='env_name',type=str)
parser.add_argument(dest='parameters',nargs='*')

args=parser.parse_args()

class M(object):
    def __init__(self):
        self.pro_name = args.pro_name
        self.env_name = args.env_name
        self.parameters = args.parameters

        self.build_ob = build.BUILD(self.pro_name,self.env_name)
        self.public_ob = public.PUBLIC(self.pro_name,self.env_name)

        self.maps = {
            "7":"self.build_ob.Maven_Build",

            "14":"self.public_ob.Remove_Cache",
        }

    def main(self):
        self.arg_list = self.parameters

        if self.env_name not in ("dev","qa","hidden","product"):
            print("\n环境参数错误.\n")
            sys.exit()

        for self.every_arg in self.arg_list:
            self.func = self.maps[self.every_arg]
            self.func_ob = str("%s()" % self.func)
            exec(self.func_ob)

if __name__ == '__main__':
    m = M()
    m.main()