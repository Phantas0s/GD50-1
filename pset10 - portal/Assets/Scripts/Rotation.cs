using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Rotation : MonoBehaviour
{
    public float speed;
    private float x;
    private float y;
    private float z;
    public bool fullRotation = false;
    private Quaternion rotation;

    // Update is called once per frame
    void Update()
    {   
        z += Time.deltaTime * speed;

        if (fullRotation)
        {
            y += Time.deltaTime * speed;
            x += Time.deltaTime * speed;
        }
    
        rotation = Quaternion.Euler(x, y, z);
        gameObject.transform.localRotation = rotation;
    }
}
