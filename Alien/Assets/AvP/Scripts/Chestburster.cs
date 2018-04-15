using UnityEngine;
using System.Collections;

public class Chestburster : MonoBehaviour 
{

    //Manager
    ChesbursterManager chestburster_man;

    //Controller
    public CharacterController controller;

    //Targets
    public Human target;

    //Quaternions
    Quaternion look;
    Quaternion rotation;

    //Gameobjects
    public GameObject alien;

    //Floats
        //Timers:
        public float timer;
        public float feed_timer;
        public float chestburst_timer;
        public float crunch_time;
        public float curr_crunch_time;
      
 
    public float gravity;
    public float feed_distance;
    public float y_adjustment;
    public float speed;

    //Vector3s
    public Vector3 velocity;

    //AudioSource
     public AudioSource chestbursting;

    //Audioclips
   public AudioClip chestburst;
   public AudioClip crunch;

  
   

    void Awake()
    {
        chestburster_man = ChesbursterManager.Instance;
    }

    void Start()
    {
        StartCoroutine(Chestburst());
        chestbursting.PlayOneShot(chestburst);
        curr_crunch_time = crunch_time;
    }

    IEnumerator Chestburst()
    {
        while(true)
        {
            yield return null;

            velocity = (transform.forward * speed) + (-transform.up * gravity);
            controller.Move(velocity * Time.deltaTime);
            chestburst_timer -= Time.deltaTime;

            if(chestburst_timer<=0)
            {
                yield return StartCoroutine(CheckTarget());
            }
        }
    }


    IEnumerator CheckTarget()
    {
        while(true)
        {
            yield return null;

            chestburster_man.GetTarget(this);

            if(target !=null)
            {
                if(target.carcass)
                {
                    yield return StartCoroutine(Run());
                }

                else
                {
                    break;
                }
            }

            else
            {
                StartCoroutine(Hide());
            }
        }
    }

    IEnumerator Run()
    {
        while(true)
        {
            yield return null;

            if(target == null)
            {
                break;
            }

            /*
            if(target.impregnated)
            {
                break;
            }
             */

            Vector3 lookdirection = target.transform.position - transform.position;
            look = Quaternion.LookRotation(lookdirection);
            look = Quaternion.Slerp(transform.rotation, look, speed * Time.deltaTime);
            transform.rotation = look;
            velocity = (transform.forward * speed) + (-transform.up * gravity);
            controller.Move(velocity * Time.deltaTime);
            
            if(Vector3.Distance(transform.position, target.transform.position) < feed_distance)
            {
                yield return StartCoroutine(Feed());
            }
             

            /*
            if(Vector3.Distance(transform.position, target.transform.position) > 20)
            {
                yield return StartCoroutine(Grow());
            }
             */
        }
    }

    IEnumerator Feed()
    {
        while(true)
        {
            yield return null;
            //animation.Play();
          
            
            curr_crunch_time -= Time.deltaTime;
            if(curr_crunch_time<=0)
            {
                chestbursting.PlayOneShot(crunch);
                curr_crunch_time = crunch_time;
            }
            

            feed_timer -= Time.deltaTime;
            if(feed_timer<=0)
            {
                yield return StartCoroutine(Grow());
            }
        }
    }

    IEnumerator Grow()
    {
        while(true)
        {
            yield return null;

            //Animation.Play();
            yield return StartCoroutine(Die());

        }
    }

    IEnumerator Hide()
    {
        while (true)
        {
            yield return null;
            //hide;
        }
    }

    IEnumerator Die()
    {
        while(true)
        {
            yield return null;

            Vector3 yo;
            yo = new Vector3(transform.position.x, transform.position.y+y_adjustment, transform.position.z);
            transform.position = yo;
            GameObject.Instantiate(alien, transform.position, alien.transform.rotation);
            Destroy(gameObject);
        }
    }
}