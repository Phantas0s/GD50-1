using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;

public class LoadSceneOnInput : MonoBehaviour {

	public string sceneToLoad;
	public string toDestroy;

	// Use this for initialization
	void Start () {
		Destroy(GameObject.Find(toDestroy));
	}
	
	// Update is called once per frame
	void Update () {
		if (Input.GetAxis("Submit") == 1) {
			SceneManager.LoadScene(sceneToLoad);
		}
	}
}
