<h1 align="center">Importing Assets</h1>

To import assets, there are four steps to follow which are listed below.

### Step1. Asset contracts deployment

- Deploy mapping contracts of the corresponding asset on the target chain, using
  the [asset template](./contracts/core/assets/erc20_asset/erc20_templete.sol).
- Ensure the total amount of contracts stay consistent with the amount on the source chain.

> Keep the owner safe, the owner has frozen permissions.

### Step2. Proxy contracts deployment

- Deploy proxy contracts on the source chain and the target chain, using
  the [proxy template](./contracts/core/lock_proxy/LockProxy.sol).

### Step3. Assets transfer

- Transfer the initialized assets to the target chain proxy contract.

### Step4. Operation contract functions

- setManagerProxy: Set the CCMP contract of the source chain and the target chain.
    - ethCCMProxyAddr: CCMP addresses are
      in [poly docs](https://github.com/polynetwork/docs/blob/master/config/README.md).
- bindProxyHash: Bind proxy contracts to each other between the source chain and the target chain.
    - toChainId: ChainIds are in [poly docs](https://github.com/polynetwork/docs/blob/master/config/README.md).
    - targetProxyHash: Contract deployed in Step2.
- bindAssetHash: Bind asset contracts to each other between the source chain and the target chain.
    - fromAssetHash: Contract deployed in Step2.
    - toChainId: ChainIds are in [poly docs](https://github.com/polynetwork/docs/blob/master/config/README.md).
    - toAssetHash: Contract deployed in Step2.

### Step5. Information submission

- Fill out this [poly asset form](./source/poly-asset.xlsx).
- Send form to [Poly Network Team](https://t.me/polynetworkgroup).

### eg:

> This is an example of the testnet.
>
>NB token hash on Polygon is: ***0x76d56873426cee920f9e8c439ee0a2cecf50d979***
>
>Cross-chain it to BNB Chain.

### Step1

- deploy NB token on BNB Chain, using the [asset template](./contracts/core/lock_proxy/LockProxy.sol).
    - NB token hash on BNB Chain: ***0x7466366d6d303f41a1876c45b1acfbc2b17123e4***.

### Step2

- deploy proxy contract on Polygon and BNB Chain, using
  the [proxy template](./contracts/core/assets/erc20_asset/erc20_templete.sol).
    - proxy contract hash on Polygon: ***0x4e5eF0CA5A94b169Fb010fb40DBFD57c4830f446***.
    - proxy contract hash on BNB Chain: ***0x097Ae585BfEf78DDC8E266ABCb840dAF7265130c***.

### Step3

- transfer all NB token on BNB Chain(***0x7466366d6d303f41a1876c45b1acfbc2b17123e4***) to proxy contract on BNB
  Chain(***0x097Ae585BfEf78DDC8E266ABCb840dAF7265130c***).

### Step4

- setManagerProxy on Polygon.
    - ethCCMProxyAddr: [***0x15D3f62822a446b8C5fDBBef157f0b82b05c29Ab***](https://github.com/polynetwork/docs/blob/master/config/README_TestNet.md#Polygon)
        - CCMP contract on Polygon.
- setManagerProxy on BNB Chain.
    - ethCCMProxyAddr: [***0x441C035446c947a97bD36b425B67907244576990***](https://github.com/polynetwork/docs/blob/master/config/README_TestNet.md#BSC)
        - CCMP contract on BNB Chain.
- bindProxyHash from Polygon to BNB Chain.
    - toChainId: [79](https://github.com/polynetwork/docs/blob/master/config/README_TestNet.md#BSC).
        - BNB Chain ChainId on poly.
    - targetProxyHash: ***0x097Ae585BfEf78DDC8E266ABCb840dAF7265130c***.
        - BNB Chain proxy contract.
- bindProxyHash from BNB Chain to Polygon.
    - toChainId: [202](https://github.com/polynetwork/docs/blob/master/config/README_TestNet.md#Polygon).
        - Polygon ChainId on poly.
    - targetProxyHash: ***0x4e5eF0CA5A94b169Fb010fb40DBFD57c4830f446***.
        - Polygon proxy contract.
- bindAssetHash from Polygon to BNB Chain.
    - fromAssetHash: ***0x76d56873426cee920f9e8c439ee0a2cecf50d979***
        - NB token hash on Polygon
    - toChainId: [79](https://github.com/polynetwork/docs/blob/master/config/README_TestNet.md#BSC).
        - BNB Chain ChainId on poly.
    - toAssetHash: ***0x7466366d6d303f41a1876c45b1acfbc2b17123e4***
        - NB token hash on BNB Chain.
- bindAssetHash from BNB Chain to Polygon.
    - fromAssetHash: ***0x7466366d6d303f41a1876c45b1acfbc2b17123e4***
        - NB token hash on BNB Chain.
    - toChainId: [202](https://github.com/polynetwork/docs/blob/master/config/README_TestNet.md#Polygon).
        - Polygon ChainId on poly.
    - toAssetHash: ***0x76d56873426cee920f9e8c439ee0a2cecf50d979***
        - NB token hash on Polygon.

### Step5

| | Chain Name | Asset Hash | Asset Contract Url | Lockproxy Hash | Lockproxy Contract Url|
|:----:|:-----:| :----:| :----: | :----:| :----: |
|Source Chain|Polygon | 0x76d56873426cee920f9e8c439ee0a2cecf50d979 | https://mumbai.polygonscan.com/address/0x76d56873426cee920f9e8c439ee0a2cecf50d979 | 0x4e5eF0CA5A94b169Fb010fb40DBFD57c4830f446 | https://mumbai.polygonscan.com/address/0x4e5eF0CA5A94b169Fb010fb40DBFD57c4830f446 | 单元格 
|Target Chain 1| BNB Chain | 0x7466366d6d303f41a1876c45b1acfbc2b17123e4 | https://testnet.bscscan.com/address/0x7466366d6d303f41a1876c45b1acfbc2b17123e4 |0x097Ae585BfEf78DDC8E266ABCb840dAF7265130c|https://testnet.bscscan.com/address/0x097Ae585BfEf78DDC8E266ABCb840dAF7265130c