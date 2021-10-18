# -verify-certs-k8s

```bash
# Crontab config
3 1 * * * /etc/verify-certs-k8s/verify-certs-job.sh > /etc/verify-certs-k8s/verify-certs-job.out
```

Pode pegar o arquivo verify-certs-k8s/verify-certs-job.out e enviar como log
