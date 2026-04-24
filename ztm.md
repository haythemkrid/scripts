# Configure Acess Guideline

## Install ZTM
```bash
cd
wget https://github.com/flomesh-io/ztm/releases/download/v1.0.0-rc2/ztm-aio-v1.0.0-rc2-generic_linux-x86_64.tar.gz

tar -xvzf ztm-aio-v1.0.0-rc2-generic_linux-x86_64.tar.gz

sudo mv bin/ztm /usr/local/bin/
```
## save the hub certificate
```bash
cat > ztm-root.json <<EOF
{"ca":"-----BEGIN CERTIFICATE-----\nMIICoTCCAYkCFG0tLm3VybluwKJDJyQhpDaWGnEGMA0GCSqGSIb3DQEBCwUAMA0x\nCzAJBgNVBAMMAmNhMB4XDTI2MDQxNzA4MzMxNVoXDTI3MDQxNzA4MzMxNVowDTEL\nMAkGA1UEAwwCY2EwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDZXqX1\nib9WgLHYXKZzGLzOgKEXg61GKDi1zjR4affOIvDtQkbc44x2NM6o94uzSDFCTN2z\nRDPA6hzcU0GIrB0eKWfM541NimJ2CPOvB1rPoopEP1VOJK+kmj644qjAkxtRniWD\nWvfkvVUqur839MBQ2SxNfqU24n7GVKfLb5uTtHwpRLBOOnkpVP6kv9bZ7LIqKb6X\noc8KFlwVpS/xfw6wXBCBytGa1ieAA//LN8q9cs3ChjRbes4dN9Ye4K8VofzI0AUw\nIsvgJlRYjTRmNWWGqfzoss6C3aaBh2Btlu/hSUQIHAF1RyQA3myglD/RDbes4KGM\n7t7mN0ifA+4a8dKbAgMBAAEwDQYJKoZIhvcNAQELBQADggEBAF335k8xhCqP8yU+\n7tHu0Mw5XOHCukhLQ/vxRIWUKMN1M4O3snqUQ651/t0YV16tBI35KX7lgMOe64rn\nqGgAVKkxfSTyoXkcZzmS/Z601U94qbsa1gTSmEgsJPioMiz44yWKUV+/f9/DyRbI\n9LpqE16C5CjPmn/h3WFjMk5rszx5xs6QVV64zmvYmYup8la3yRZEMKkzB52kHrWx\nCJ52OMQzUmjw9vQhDZLU9vm/oiidUnllUlCk5JDf4hz//kE9eLvb7IRW23LBWF4W\nBJQGO84uFSWcgakVl97ZsvMUXUAyY9cq37osqU/Xphjmx3Ppx7umK90wVlsejZpf\n7IPVg80=\n-----END CERTIFICATE-----\n","agent":{"certificate":"-----BEGIN CERTIFICATE-----\nMIICozCCAYsCFGOeRqKgGe+lqnnO8sT3OeQxJRgoMA0GCSqGSIb3DQEBCwUAMA0x\nCzAJBgNVBAMMAmNhMB4XDTI2MDQxNzA4MzMxNVoXDTI3MDQxNzA4MzMxNVowDzEN\nMAsGA1UEAwwEcm9vdDCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAMQ0\nEHlXXBGH9ZfNfaXsoBqLUZaL2HypbuXIxujxII5pFiQC8GQs/e424rYAVc2r9Q4T\nD50ZYe6vZRc+R0MSXj9LUpfWot/YWoA8Bzfh6Df1svMwqTzco7Us/0GxLKEqiJ42\nUmYxH3sakaq+xVeh1h4X8tAX+/8eiZ8nBpXV49DSc2emnsFejBxsEl/wLog+x+Ul\nSi2bJTOdJcX6wGoJS2lfoV5pS7SLzSYickAPcqaSr3XFdd0WrG5+bYWBvtGM2BUK\nXR36uT/5mLDe8Xwpl89xRIIx4Z92ZYZUils/jHCr/bcAES0LPM14sdFO5EGZn+oS\n+eraUlRzsSlQrYVnsi8CAwEAATANBgkqhkiG9w0BAQsFAAOCAQEALQSh4pubGwZB\nVret7bdwpey1QZZl1h5/wZwO6IObGquxtx3jtqArQISoDAe9Ijb/G+4kFLI+h8nj\nyJg1aq0cgkBHEVsX1ExLnM1a74OI7tKraHycxdpD3v97HCiCyoPoSbVt1GS7TaVk\noWqr8xEZxvExQvypmCXWdRXtSpHCV95omUklYxCQV76HkuNNaBQ/Z7rNeuCqgASy\nWSNqTDVQYuH9PrbJ7CksQSLmnOfZ5p8zMdlAlp3spidZCY/uYaQGZXVmPS3U51VA\n5YHexjf3XTF6GEtwQpHB9Yv91cdrit7zuepqHNOH6IhkBubwe2NrrFKvdqCNW/hW\nRFxXsZCW+w==\n-----END CERTIFICATE-----\n","privateKey":"-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQDENBB5V1wRh/WX\nzX2l7KAai1GWi9h8qW7lyMbo8SCOaRYkAvBkLP3uNuK2AFXNq/UOEw+dGWHur2UX\nPkdDEl4/S1KX1qLf2FqAPAc34eg39bLzMKk83KO1LP9BsSyhKoieNlJmMR97GpGq\nvsVXodYeF/LQF/v/HomfJwaV1ePQ0nNnpp7BXowcbBJf8C6IPsflJUotmyUznSXF\n+sBqCUtpX6FeaUu0i80mInJAD3Kmkq91xXXdFqxufm2Fgb7RjNgVCl0d+rk/+Ziw\n3vF8KZfPcUSCMeGfdmWGVIpbP4xwq/23ABEtCzzNeLHRTuRBmZ/qEvnq2lJUc7Ep\nUK2FZ7IvAgMBAAECggEACRO/j12TTNxVaGiBX6PK5G99ntFpepr8HnVjfnNpZi1G\ncPQR2xCZzuOLKZBqZ9GEzNnk5we9mCVVL/YZpei7o4IAmDW9401HIpekXdl9vNkJ\nJmch7Ubn7AHg7VEdF3e4SlmJBmFPa4qXIqcgyiUamtnQyf/SEMOA6nQLwfLbT1XY\ndDp/0IqBM2/aAW23JHxxmKA1XgWvFBjjZcp5gwYgm18oz/JfktmSnCrWD0HPSDDX\neEFOkdE0kLHcmd2vvRcZR6M0K7dkhso3PzirDD7mcK41M+/bnoO3uw1fuciblz6F\nBTU6Z5tnwNlCRtd97z+oi3GspaKvgWWwb/dKKdaBgQKBgQDgNXbqm6+sXPnoH41X\napTEKFoKbCaCSsiRZldgAhIpNUuwBXeZ6fE5e/dIpBs0HEHmxfEBsdhtb1bJTAmx\nJL1TS/t9SKs0TCaODrvrspzc4zTnOwkdlaLBMtoZ9uBqvmYtzUGPbkms3KGIaP1E\nwazcGWO9J05Vwh0Xm31Jt+sHBwKBgQDgBggvf//IR8zkkiP5YOhRqbqILfKEXQM6\nphDcOhB+nXg7uUQkLczGg+IGTvZk32nN/3gDx0s3Z/v2/dXOn2ZIxqc1CFhHo4z1\nkpu9GRb5GcZWV55VZmvE2iO+0RfBHisb7O5/T31lBwuVeQ5ZW6c1tM2gHXCIuROS\n/1OMPDTJmQKBgBPaSBRQAsclWG+IU7CY3GFeHVLs7p/81TOitzvmEwuZD4Gfik6T\nm2t2oZfKCCqeEevIPSXkRIC0KiAa3oTT9vuoL7WROK+hyowrm9Ir953LdITBAnaf\nKFEpGozQAmERSOTnVtXHczieNKNqgHqVF6RJjz5Re6s2S/MqLnbXlTUDAoGABVNf\nYnGyjPpX/p8Sx9zr6PUWACLHfyoO55gHEpU2yyvHLfRLkGieU6HS/79k0CUXiNQn\n8D8OpLSOIuMJ8C2N6vD+DJ60Ko/SzAu+NBKiny1jr63Jj9ItgbKF4wVpgSfMco+B\nY/lpy7sNJXKJSsqJARfZQ5Mvl7B+rKHxRIYx4xECgYEAqE2wSLW+7s1tNkM5+tK9\nOM+qRv/kppE3+SgdWohrzxTo0mooc0uo8vjxa9ZkFbUwJiR4RAD1kxB6HoRVFqNk\nbyU+aPh/FuMMxQa40HkeO/218L+U99/auCaCN6FOwwSpNu+SZERxhk8RaRQalaGi\ncDCTww37wqMqjYrAeVTOFLU=\n-----END PRIVATE KEY-----\n"},"bootstraps":["212.2.243.37:8888"]}
EOF
```

## start the ztm agent
```bash
sudo systemctl enable ztm-agent.service
sudo ztm start agent
```

# Set your Endpoint Name and join the mesh
```bash
sudo ztm join my-mesh --as EP_NAME_change_me --permit ztm-root.json
```

# Get eps in your mesh network
```bash
sudo ztm get ep
```


# Access the terminal of an ep
```bash
sudo ztm terminal open SERVER_EP
```
# Login via your user inside the server
```bash
su - myuser
```
