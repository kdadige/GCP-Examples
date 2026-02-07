# GCP-Examples

# Install Terraform

# https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli

# Install HashiCorp's GPG key.
```sh
wget -O- https://apt.releases.hashicorp.com/gpg | \
gpg --dearmor | \
sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg > /dev/null
```
# Verify the GPG key's fingerprint.
```sh
gpg --no-default-keyring \
--keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg \
--fingerprint
```

# The gpg command reports the key fingerprint:

```
/usr/share/keyrings/hashicorp-archive-keyring.gpg
-------------------------------------------------
pub   rsa4096 XXXX-XX-XX [SC]
AAAA AAAA AAAA AAAA
uid         [ unknown] HashiCorp Security (HashiCorp Package Signing) <security+packaging@hashicorp.com>
sub   rsa4096 XXXX-XX-XX [E]

```

# Add the official HashiCorp repository to your system.

```sh
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(grep -oP '(?<=UBUNTU_CODENAME=).*' /etc/os-release || lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
```

# Update apt to download the package information from the HashiCorp repository.

```sh
sudo apt update
```

# Install Terraform from the new repository.

```sh
sudo apt-get install terraform
```