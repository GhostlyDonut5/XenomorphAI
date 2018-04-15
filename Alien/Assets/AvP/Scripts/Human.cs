using UnityEngine;
using System.Collections;

public class Human : MonoBehaviour 
{
    public bool facehugged;
    public bool targeted;
    public bool carcass;
    public bool impregnated;
    public bool attacked;
    public float timer;
    public float current_timer;
    public float hp;
    public GameObject chestburster;
    public Facehugger facehugger;

    void Start()
    {
        current_timer = timer;
        StartCoroutine(Idle());
    }

    IEnumerator Idle()
    {
        while(true)
        {
            yield return null;

            if(hp<=0)
            {
                StartCoroutine(Carcass());
            }

            if(facehugged == true)
            {
                yield return StartCoroutine(Facehugged());
            }
        }
    }

    IEnumerator Facehugged()
    {
        while(true)
        {
            yield return null;
            //animation.Play();

            if(impregnated == true)
            {
                yield return StartCoroutine(ChestBurst());
            }
        }
    }
        

    IEnumerator ChestBurst()
    {
        while(true)
        {
            yield return null;

                current_timer -= Time.deltaTime;

                if (current_timer <= 0)
                {
                    GetComponent<AudioSource>().Play();
                    GameObject.Instantiate(chestburster, transform.position, transform.rotation);
                    yield return StartCoroutine(Carcass());
                }

            
        }
    }

    IEnumerator Carcass()
    {
        while(true)
        {
            yield return null;
            carcass = true;

        }
    }
}
