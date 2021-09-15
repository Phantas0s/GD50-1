using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class MovePlatform : MonoBehaviour
{
    public float speed;
    public GameObject Player;

    // Update is called once per frame
    void Update()
    {   
        changeDirection();
        transform.Translate(Vector3.back * speed * Time.deltaTime);
    }

    public void changeDirection()
    {
        if (transform.position.z > 0)
        {
            transform.position = new Vector3(transform.position.x, transform.position.y, 0);
            speed = -speed;
        }
        else if (transform.position.z < -40)
        {
            transform.position = new Vector3(transform.position.x, transform.position.y, -40);
            speed = -speed;
        }
    }

    void OnTriggerEnter(Collider other)
    {
        if (other.gameObject == Player)
        {
            Player.transform.parent = transform;
        }

        if (other.gameObject.name == "Ring")
        {
            speed = -speed;
        }
    }

    void OnTriggerExit(Collider other)
    {
        if (other.gameObject == Player)
        {
            Player.transform.parent = null;
        }
    }
}
