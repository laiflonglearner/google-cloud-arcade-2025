# Lab 27: Transacting Digital Assets with Multi-Party Computation and Confidential Space

Warnings:

- Note: For this lab, we are showing MPC-compliant signature operation, but we are over-simplifying the key generation step (and not doing distributed key share generation in multiple locations). We do not expect organizations to do this for real production applications.
- Note: In a production scenario, keys should never be stored in plaintext files. Instead, the private key can be generated outside of Google Cloud (or skipped entirely and replaced with custom MPC key shard creation) and then encrypted so that no one sees or has access to the private key or the key shares. For the purposes of this lab we'll be using the gcloud CLI.
