### LMD short tutorial ###
This repository is used for my short introduction to LMD and all the hex voodoo of DAQ.

Clone this repo:
```
https://github.com/kLayz3/lmd-training
```

Enter the directory:
```
cd lmd-training
```

Also clone `ucesb`:
```
https://git.chalmers.se/expsubphys/ucesb.git
```

Enter ucesb and make empty target:
```
cd ucesb && make -j4 empty
```

Add the exe to path or bashrc:
```
export PATH=$PATH:$PWD/ucesb/empty/empty
```
