# Partie 2 – Automatisation et Infrastructure as Code

**Étudiante :** Amal Jemli – Master DevOps et Cloud Computing (2026/2027)
**Énoncés :** [Partie 2 – TP4 à TP6](https://docs.teknolabs.net/courses/devops-cloud/partie-2-automatisation-iac/)

| TP | Sujet | Outils | Dossier |
|---|---|---|---|
| TP4 | Bases d'Ansible : inventaire, playbook idempotent, clés SSH, conteneurs, rôles | Ansible 9 (core 2.16), Docker, Jenkins, Portainer | [tp4-ansible-bases](tp4-ansible-bases/) |
| TP5 | Environnements de lab reproductibles | Vagrant 2.4.9, VirtualBox 7.2, Ansible (`ansible_local`) | [tp5-vagrant](tp5-vagrant/) |
| TP6 | Infrastructure as Code et intégration Vagrant → Ansible → Terraform | Terraform 1.17, provider `kreuzwerker/docker` 3.9, Docker Hub, nginx | [tp6-terraform](tp6-terraform/) |

Chaque dossier contient son README (étapes, explications et captures demandées), le code et un dossier `captures/`.

## Lab commun aux trois TP

Un seul `Vagrantfile` ([tp5-vagrant/lab/Vagrantfile](tp5-vagrant/lab/Vagrantfile)) crée trois VM Ubuntu 24.04 (`bento/ubuntu-24.04`) sur le réseau privé VirtualBox. L'hôte est un PC Windows (15 Go de RAM).

```
 PC Windows (VirtualBox + Vagrant)
 │
 ├── control    192.168.56.80  1 Go    Ansible, Terraform, Docker (reverse proxy du TP6)
 ├── webserver  192.168.56.81  2,5 Go  Apache (TP4) · Jenkins :8080 · Portainer :9443 · site :8081 · CV :8001 (TP6)
 └── ftpserver  192.168.56.82  2,5 Go  Apache (TP4) · Jenkins :8080 · Portainer :9443 · site :8081 · CV :8002 (TP6)
```

- **TP4** : `control` gère `webserver` et `ftpserver` avec Ansible (utilisateur `devops`, d'abord par mot de passe, puis par clé ed25519).
- **TP5** : Vagrant provisionne les deux VM avec les **rôles du TP4** (provisioner `ansible_local` exécuté depuis `control`).
- **TP6** : Terraform pilote Docker en local, puis à distance par SSH ; Ansible installe Terraform sur les deux VM qui lancent le CV (image publiée sur Docker Hub : `amal878/cv-onepage:1.0`) ; un reverse proxy nginx sur `control` sert de point d'entrée unique.

## Sécurité

- Le compte `devops` (mot de passe `devops`) et l'authentification SSH par mot de passe n'existent que dans ce **lab local** (réseau host-only, non exposé). Après la partie 3 du TP4, Ansible se connecte par clé SSH.
- Aucun secret dans le dépôt : `terraform.tfstate`, `.terraform/` et `*.tfvars` sont exclus par le `.gitignore` ; l'identifiant Docker Hub a été saisi à la main, puis supprimé avec `docker logout`.
