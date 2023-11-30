### LMD short tutorial ###
This repository is used for my short introduction to LMD and all the hex voodoo of DAQ.

After cloning this repository, also clone `ucesb`:
```
https://git.chalmers.se/expsubphys/ucesb.git
```

Enter ucesb and make empty target:
```
cd ucesb && make -j4 empty
```

Symlink the executable, or add it to path/bashrc:
```
cd ../ && ln -s ./ucesb/empty/empty empty
```
