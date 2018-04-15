using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Hello : MonoBehaviour {

	// Use this for initialization
	void Start () {
        StartCoroutine(hi());
		
	}
	
	// Update is called once per frame
	void Update () {
		
	}

    public IEnumerator hi()
    {
        yield return null;
        Debug.Log("Hello");
    }
}
