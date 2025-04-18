1. Integrate items endpoints from https://www.steamwebapi.com/ into the GigaSwap front-end and back-end applications.

2. Start working on /market front-end page
    - /market page should have real Steam Products. For now, the real Steam Products should be based on a hardcoded list of Steam items based on the market_hash_name (e.g. AK-47 Redline (Field Tested)).
    - To populate this hardcoded list, use the /steam/api/items endpoint from steamwebapi.com. We will likely need to test the steamwebapi.com endpoints manually because they don't have that great of documentation. Their list of api endpoints is here: https://www.steamwebapi.com/api/list . This should be the first endpoint that we integrate. 
    - /market page should sort items based on item_group, item_type, and item_name. We should only have a couple of products for now.

3. Create next steps to finish this CS2 Skin Marketplace, which is run entirely through decentralized payments and seamless trading (no user information other than wallet addresses).

4. Create context for the Steam Web API integration so that we can continue to edit and refine for the future.
