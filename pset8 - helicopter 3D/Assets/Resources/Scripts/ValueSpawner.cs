using UnityEngine;
using System.Collections;

public class ValueSpawner : MonoBehaviour {

	public GameObject[] prefabs;

	// Use this for initialization
	void Start () {
		
		// Add the coin prefab to the prefabs array
		prefabs[0] = Resources.Load<GameObject>("Prefabs/Coin");
		// Add the diamond prefab to the prefabs array
		prefabs[1] = Resources.Load<GameObject>("Prefabs/Diamond");

		// infinite coin spawning function, asynchronous
		StartCoroutine(SpawnValues());
	}

	// Update is called once per frame
	void Update () {

	}

	IEnumerator SpawnValues() {
		while (true) {
			
			// 1 in 5 chance to spawns a diamond 
			if (Random.Range(1, 5) == 1) {
				Instantiate(prefabs[1], new Vector3(26, Random.Range(-10, 10), 10), Quaternion.identity);
			}
			else {
				// number of coins we could spawn vertically
				int coinsThisRow = Random.Range(1, 4);

				// instantiate all coins in this row separated by some random amount of space
				for (int i = 0; i < coinsThisRow; i++) {
					Instantiate(prefabs[0], new Vector3(26, Random.Range(-10, 10), 10), Quaternion.identity);
				}
			}

			// pause 1-5 seconds until the next coin spawns
			yield return new WaitForSeconds(Random.Range(1, 5));
		}
	}
}
