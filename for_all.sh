#! /bin/sh

[ -f ssh_config ] || vagrant ssh-config > ssh_config
for i in $(grep -w Host ssh_config | cut -f2 -d' '); do
  echo $i
  ssh -F ssh_config $i $*
done
