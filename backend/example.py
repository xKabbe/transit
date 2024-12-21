import requests

if __name__ == "__main__":
    # How to Use TAP https://exoplanetarchive.ipac.caltech.edu/docs/TAP/usingTAP.html

    # NASA Exoplanet Archive API endpoint
    url = "https://exoplanetarchive.ipac.caltech.edu/TAP/sync"

    # Query for confirmed planets
    query = "select pl_name, pl_masse from ps where dec > 0 and pl_masse between 0.5 and 2.0"
    response = requests.get(url + "?query=" + query + "&format=json")

    print(response.json())
