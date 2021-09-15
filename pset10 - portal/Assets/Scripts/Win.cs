using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Win : MonoBehaviour
{   
    public GameObject WinCanvas;

    void OnTriggerEnter(Collider other)
    {
        Victory();
    }

    void Victory()
    {
        transform.parent.Find("Ring").gameObject.GetComponent<Rotation>().fullRotation = true;
        transform.parent.Find("Ring").gameObject.GetComponent<Rotation>().speed = 40f;
        WinCanvas.SetActive(true);
    }
}
