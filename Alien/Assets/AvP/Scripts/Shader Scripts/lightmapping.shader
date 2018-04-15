using UnityEngine;
using System.Collections;

public class Egg : MonoBehaviour 
{

    public Transform target;
    public float timer;
    public GameObject facehugger;
	// Use this for initialization
	void Start () 
    {
        target = GameObject.FindWithTag("Player").transform;

       StartCoroutine("Sit");
   	}


    IEnumerator Sit()
    {
        while(true)
        {
            yield return null;

            if (Vector3.Distance(transform.position, target.transform.position)<10)
            {
               yield return StartCoroutine("Hatch");
            }

        }
    }

    IEnumerator Hatch()
    {
        while (true)
        {
            yield return null;

            animation.Play();
            Instantiate(facehugger, transform.position, transform.rotation);
          //yield return StartCoroutine("Used");
        }
    }

    IEnumerator Used()
    { 
        while(true)
        {
            yield return null;

            timer -= Time.deltaTime;
            if (timer <= 0)
            {
                Destroy(gameObject);
            }
        }
    }
}
