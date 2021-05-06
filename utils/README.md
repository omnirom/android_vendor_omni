# How to use the scripts.

1. You need to be on top level repo dir.

2. Launch the scripts

```
cd vendor/omni/utils
./aosp-merge.sh
```

 * Now enter to the desired aosp tag
 * Wait for the script will finish

 * If during the merge script you have some "MERGE CONFLICT", you need to resolve it first:
        *Check the path of the repo conflict and type

```
cd ${path_to_repo}
git status
```

 * Fix the files pb
 * When it's done, type again:

```
git add .
git commit --no-edit
git checkout ${android_version}
git merge ${branch-merge}
```

** Example like:
   * ${path_to_repo} = frameworks/base
   * ${android_version} = android-11
   * ${branch-merge} = android-11.0.0_r37-merge where android-11.0.0_r37 is the aosp tag name used

3. Pushing to Omnirom gerrit

 * Go again to the Omni utils dir.

```
cd vendor/omni/utils
./aosp-merge.sh
```
 * Enter now your username of your gerrit account.
 * Enter the topicname for the merging stuff of the aosp tag
 * Done.

4. Repeat the whole "HOW TO" for the CAF script (Optional)

 * But replace the aosp-merge.sh and aosp-merge.sh by caf-merge.sh and caf-merge.sh

5. Enjoy :)