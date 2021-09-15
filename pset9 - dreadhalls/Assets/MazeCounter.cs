using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

[RequireComponent(typeof(Text))]
public class MazeCounter : MonoBehaviour
{
    private Text mazeText;
    
    // Start is called before the first frame update
    void Start()
    {
        mazeText = GetComponent<Text>();
        mazeText.text = "Mazes: " + GrabPickups.counter;
    }

    // Update is called once per frame
    void Update()
    {
        
    }
}
