# Kitchen Ansible Example

The purpose of this repo is to show a very rudimentary how-to-use of the [kitchen-ansible Gem](https://github.com/neillturner/kitchen-ansible).

I primarily work with test-kitchen as a vehicle for developing and test Chef cookbooks, but a few years ago, I had to build out an ansible playbook for another part of my company to install another copy of an application that I had been managing the DevOps lifecycle for. I originally looked at the de-facto setup for rapid development of Ansible playbooks, [Molecule](https://github.com/ansible/molecule), and ended up not liking several aspects of the way it worked. Also, it was a little slow.

With kitchen-ansible and kitchen-docker, I could complete a full lifecycle in less than a minute, and I got to keep my familiar tooling, including Inspec.

## Requirements

- Docker
- Ruby with bundler
  - Preferrably also a ruby version manager like asdf-vm

## Usage

Download the repo, install the gems, and run test kitchen:
```
bundle install
bundle exec kitchen test
```

You should see the gems install, then test-kitchen will build the container from a synthetic Dockerfile and install Ansible in it using the `provision_command` section found in the platform definition of `kitchen.yml`.

After that, the continer will start, kitchen-ansible will copy over the playbook files, and start Ansible.

When the ansible run completes, it'll run the inspec test.

<details>
<summary>Example test-kitchen output</summary>

```
-----> Testing <default-rockylinux-9>
-----> Creating <default-rockylinux-9>...
       #0 building with "default" instance using docker driver

       #1 [internal] load build definition from Dockerfile-kitchen20250514-98628-d40bo7
       #1 transferring dockerfile: 1.77kB done
       #1 DONE 0.0s

       #2 [internal] load metadata for docker.io/dokken/rockylinux-9:latest
       #2 DONE 0.0s

       #3 [internal] load .dockerignore
       #3 transferring context: 2B done
       #3 DONE 0.0s

       #4 [ 1/21] FROM docker.io/dokken/rockylinux-9:latest@sha256:9db7baa307d1d373298679009b71a9fbf34d1c415b7c5325250804b6f49604d6
       #4 resolve docker.io/dokken/rockylinux-9:latest@sha256:9db7baa307d1d373298679009b71a9fbf34d1c415b7c5325250804b6f49604d6 done
       #4 DONE 0.0s

       #5 [ 7/21] RUN mkdir -p /etc/sudoers.d
       #5 CACHED

       #6 [ 6/21] RUN if ! getent passwd kitchen; then                   useradd -d /home/kitchen -m -s /bin/bash -p '*' kitchen;                 fi
       #6 CACHED

       #7 [11/21] RUN mkdir -p /home/kitchen/.ssh
       #7 CACHED

       #8 [ 3/21] RUN yum install -y sudo openssh-server openssh-clients which
       #8 CACHED

       #9 [10/21] RUN echo "Defaults !requiretty" >> /etc/sudoers.d/kitchen
       #9 CACHED

       #10 [18/21] RUN yum -y install python3 python3-pip
       #10 CACHED

       #11 [16/21] RUN chmod 0600 /home/kitchen/.ssh/authorized_keys
       #11 CACHED

       #12 [14/21] RUN touch /home/kitchen/.ssh/authorized_keys
       #12 CACHED

       #13 [19/21] RUN python3 -m pip install --upgrade pip
       #13 CACHED

       #14 [13/21] RUN chmod 0700 /home/kitchen/.ssh
       #14 CACHED

       #15 [ 5/21] RUN [ -f "/etc/ssh/ssh_host_dsa_key" ] || ssh-keygen -t dsa -f /etc/ssh/ssh_host_dsa_key -N ''
       #15 CACHED

       #16 [ 9/21] RUN echo "kitchen ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers.d/kitchen
       #16 CACHED

       #17 [12/21] RUN chown -R kitchen /home/kitchen/.ssh
       #17 CACHED

       #18 [ 2/21] RUN yum clean all
       #18 CACHED

       #19 [ 4/21] RUN [ -f "/etc/ssh/ssh_host_rsa_key" ] || ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key -N ''
       #19 CACHED

       #20 [ 8/21] RUN chmod 0750 /etc/sudoers.d
       #20 CACHED

       #21 [15/21] RUN chown kitchen /home/kitchen/.ssh/authorized_keys
       #21 CACHED

       #22 [17/21] RUN mkdir -p /run/sshd
       #22 CACHED

       #23 [20/21] RUN LC_ALL="en_US.UTF-8" python3 -m pip install ansible
       #23 CACHED

       #24 [21/21] RUN echo ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCthyu/+yBwjdrRSHw9A9kPL2mLBa0jBX1UuE2WOoTni/tlt/Nzu+zMjDj95FN0IIkS94pBx9dVf8N/nmqiNgPtdnzxx2armbDIBhejT9FluR8p+mJcU/ds8nalMN+76EkW9BKtOwAESMiAwug9c03xmYC9HNObq9N6qn4ovg/Aka5P9M6UxJxOwxbbQ0BmqURzDnNsNYOX8DBmfisk0SZ1AjZoIVPNzVHoJVFlK8MXd7IcX82cJIW0ozA3abby6jx17xceVpyU03JudoGWNQaxI2IN66hWt1tDn/fzJ0p82N2Ef5YfYXBcjOXNEJAkaaxeZMKYuUOm3COGwfV1mlvJ kitchen_docker_key >> /home/kitchen/.ssh/authorized_keys
       #24 CACHED

       #25 exporting to image
       #25 exporting layers done
       #25 exporting manifest sha256:0a2c4f7e4fe69e531c7bbe15a84d5188d67445a96962b3bd60488d6230e9e9d3 done
       #25 exporting config sha256:2146194dc26d9ca5cd3fc21f373e96e73984c9965e4dd14a657b2e5fea0ba095 done
       #25 exporting attestation manifest sha256:6446f8a8376a83e75c618e533fa688232adc2c5b3d75bdde80a5403a4b475631 0.0s done
       #25 exporting manifest list sha256:77d7aedbd58daba1f702823fece2edc2a8e50e3f2946aab08010651a9c504a24 done
       #25 naming to moby-dangling@sha256:77d7aedbd58daba1f702823fece2edc2a8e50e3f2946aab08010651a9c504a24 done
       #25 unpacking to moby-dangling@sha256:77d7aedbd58daba1f702823fece2edc2a8e50e3f2946aab08010651a9c504a24 done
       #25 DONE 0.1s

       View build details: docker-desktop://dashboard/build/default/default/u9ertf5kl9nl8iwlmvavj8y57
       70c8ed26e2c0d3ab0e652cf53ec6d2e2ab67b6bc7635fbcfc171d2ecdca56a67
       0.0.0.0:61812
       Finished creating <default-rockylinux-9> (0m0.76s).
-----> Converging <default-rockylinux-9>...
       Preparing files for transfer
       Preparing playbook
       Preparing inventory
       Preparing modules
       nothing to do for modules
       Preparing roles
       Preparing ansible.cfg file
       Empty ansible.cfg generated
       Preparing group_vars
       nothing to do for group_vars
       Preparing additional_copy_path
       Copy additional path: ./tasks
       Copy additional path: ./collections
       Preparing host_vars
       nothing to do for host_vars
       Preparing hosts file
       Preparing spec
       nothing to do for spec
       Preparing library plugins
       nothing to do for library plugins
       Preparing callback plugins
       nothing to do for callback plugins
       Preparing filter_plugins
       nothing to do for filter_plugins
       Preparing lookup_plugins
       nothing to do for lookup_plugins
       Preparing ansible vault password
       Preparing additional_ssh_private_keys
       nothing to do for additional_ssh_private_keys
       Finished Preparing files for transfer
       Installing ansible, will try to determine platform os
       [Docker] Executing command on container
       [Docker] Executing command on container
       Transferring files to <default-rockylinux-9>
       [Docker] Executing command on container
       [Docker] Executing command on container
       Using /etc/ansible/ansible.cfg as config file

       PLAY [Kitchen-Ansible Example] *************************************************

       TASK [Gathering Facts] *********************************************************
       ok: [localhost]

       TASK [Greet the user] **********************************************************
       ok: [localhost] => {
           "msg": "Hello, World! This is a test run of Ansible using kitchen-ansible gem."
       }

       PLAY RECAP *********************************************************************
       localhost                  : ok=2    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0

       Downloading files from <default-rockylinux-9>
       Finished converging <default-rockylinux-9> (0m2.54s).
-----> Setting up <default-rockylinux-9>...
       Finished setting up <default-rockylinux-9> (0m0.00s).
-----> Verifying <default-rockylinux-9>...
       Loaded kitchen-ansible-example

Profile:   Test Kitchen Ansible Example (kitchen-ansible-example)
Version:   0.0.1
Target:    docker://70c8ed26e2c0d3ab0e652cf53ec6d2e2ab67b6bc7635fbcfc171d2ecdca56a67
Target ID: 5ff84442-72d2-5ecf-8715-edf931c3dda0

  ✔  Service Checker: Checks that the services configured in the input are running
     ✔  Service sshd is expected to be installed
     ✔  Service sshd is expected to be enabled
     ✔  Service sshd is expected to be running


Profile Summary: 1 successful control, 0 control failures, 0 controls skipped
Test Summary: 3 successful, 0 failures, 0 skipped
       Finished verifying <default-rockylinux-9> (0m2.58s).
-----> Destroying <default-rockylinux-9>...
       [Docker] Destroying Docker container 70c8ed26e2c0d3ab0e652cf53ec6d2e2ab67b6bc7635fbcfc171d2ecdca56a67
       UID                 PID                 PPID                C                   STIME               TTY                 TIME                CMD
       root                83206               83183               2                   02:10               ?                   00:00:00            /usr/lib/systemd/systemd
       root                83247               83206               0                   02:10               ?                   00:00:00            /usr/lib/systemd/systemd-journald
       root                83346               83206               0                   02:10               ?                   00:00:00            /usr/sbin/atd -f
       root                83347               83206               0                   02:10               ?                   00:00:00            /usr/sbin/crond -n
       81                  83355               83206               0                   02:10               ?                   00:00:00            /usr/bin/dbus-broker-launch --scope system --audit
       root                83358               83206               0                   02:10               ?                   00:00:00            sshd: /usr/sbin/sshd -D [listener] 0 of 10-100 startups
       81                  83360               83355               0                   02:10               ?                   00:00:00            dbus-broker --log 4 --controller 9 --machine-id 2b4b166324ba4cc98623c8cc6ebb5ce6 --max-bytes 536870912 --max-fds 4096 --max-matches 16384 --audit
       root                83362               83206               1                   02:10               ?                   00:00:00            /usr/lib/systemd/systemd-logind
       root                83364               83206               0                   02:10               ?                   00:00:00            /usr/lib/systemd/systemd --user
       root                83367               83364               0                   02:10               ?                   00:00:00            (sd-pam)
       70c8ed26e2c0d3ab0e652cf53ec6d2e2ab67b6bc7635fbcfc171d2ecdca56a67
       70c8ed26e2c0d3ab0e652cf53ec6d2e2ab67b6bc7635fbcfc171d2ecdca56a67
       Finished destroying <default-rockylinux-9> (0m0.34s).
       Finished testing <default-rockylinux-9> (0m6.64s).
-----> Test Kitchen is finished. (0m7.62s)
```

</details>

## Notes

I'm using my custom fork of the kitchen-docker gem because it supports the docker transport and I find that convenient, although the driver needs a general overhaul that I have never found the time to write. 

kitchen-ansible _will not_ work with kitchen-dokken. Consider using something like kitchen-ec2, or deal with the peculiarities of kitchen-docker until I get around to the mega patch that it needs to bring it up to speed.
