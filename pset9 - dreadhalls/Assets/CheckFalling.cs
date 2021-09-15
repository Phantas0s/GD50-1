using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;

public class CheckFalling : MonoBehaviour
{   
    private Transform transf;

    // Start is called before the first frame update
    void Start()
    {
        transf = GetComponent<Transform>();
    }

    // Update is called once per frame
    void Update()
    {
        if (transf.position.y < -10) {
            SceneManager.LoadScene("Gameover");
		    GrabPickups.counter = 0;
        }
    }
}
