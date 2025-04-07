### Develop

1. Open vscode workspace via devcontainer
2. Setup local cluster
    ```
    make cluster
    ```
3. Run shell-operator
    ```
    make debug
    ```
4. Apply sample CR
    ```
    kubectl apply -k ./config/samples/
    ```


# Holst

- https://app.holst.so/board/15f51746-74a5-4dcb-ac96-cc8d1be89c17