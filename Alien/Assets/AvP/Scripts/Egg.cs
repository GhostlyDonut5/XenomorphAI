using UnityEngine;
using System.Collections;

public class Egg : MonoBehaviour 
{
    
    public GameObject[] target;
    //public GameObject parent;
    //float f;
    //float g;
    //float h;
    public float timer;
    public GameObject facehugger;
    //int i;
	// Use this for initialization
	void Start () 
    {
            target = GameObject.FindGameObjectsWithTag("Player");
            //target = CompareTag("Player");
            StartCoroutine("Sit");
   	}


    IEnumerator Sit()
    {
        while (true)
        {
            yield return null;

            {
                for(int i = 0; i < target.Length; i++)
                {
                    if (Vector3.Distance(transform.position, target[i].transform.position) < 10)
                    {
                      yield return StartCoroutine("Hatch");
                    }
                }

            }
        }
    }
    

    IEnumerator Hatch()
    {
        while (true)
        {
            yield return null;

            GetComponent<Animation>().Play();
            Instantiate(facehugger, transform.position, transform.rotation);
           yield return StartCoroutine("Used");
        }
    }

    IEnumerator Used()
    { 
        while(true)
        {
            yield return null;

            /*
            timer -= Time.deltaTime;
            if (timer <= 0)
            {
                Destroy(gameObject);
            }
             */
        }
    }
}