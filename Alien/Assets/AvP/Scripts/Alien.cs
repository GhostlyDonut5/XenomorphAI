using UnityEngine;
using System.Collections;

public class Alien : MonoBehaviour 
{
    AlienManager alien_man;
    public CharacterController controller;
    public Human target;
    public float speed;
    public float run_speed;
    public float lunge_speed;
    public float rate_of_attack;
    public float attack_distance;
    public float gravity;
    public Vector3 velocity;
    Quaternion look;
    Vector3 lookdirection;
    Vector3 rotation;
    public Animator anim;
	// Use this for initialization

    void Awake()
    {
        alien_man = AlienManager.Instance;
        //anim = GetComponent<Animator>();
        anim = GetComponentInChildren<Animator>();
    }

	void Start () 
    {
        //target = GameObject.FindWithTag("Player").transform;
        StartCoroutine(CheckTarget());
	}
 
    IEnumerator CheckTarget()
    {
        while(true)
        {
           yield return null;
         
            alien_man.GetTarget(this);
            
            if(target!=null)
            {
                if(!target.attacked)
                {
                    if(!target.carcass)
                    {
                        anim.SetBool("idle", false);
                        yield return StartCoroutine(Move());
                    }              
                }

                else
                {
                    break;
                }
            }

            else
            {
                yield return StartCoroutine(Idle());
            }
        }
    }


    IEnumerator Idle()
    {
        while (true)
        {
            yield return null;
            /*
            if(target == null)
            {
                Start();
            }

            
            if(target.facehugged == true)
            {
                break;
            }

            if(target.carcass == true)
            {
                break;
            }
            */
            anim.SetBool("idle", true);
            if(target==null)
            {
                yield return StartCoroutine(CheckTarget());
            }
            
        }
    }

    IEnumerator Move()
    { 
        while(true)
        {
            yield return null;
            //animation.Play();

            if (target == null)
            {
                Start();
                break;
            }

            if (target.facehugged == true || target.carcass == true)
            {
                anim.SetBool("walk", false);
                break;
            }

            
            anim.SetBool("walk", true);

            velocity = (transform.forward * run_speed) + (-transform.up * gravity);
            controller.Move(velocity * Time.deltaTime);
            lookdirection = target.transform.position - transform.position;
            look = Quaternion.LookRotation(lookdirection);
            look = Quaternion.Slerp(transform.rotation, look, speed * Time.deltaTime);
            transform.rotation = look;
            transform.localRotation = look;
            
           
            if (Vector3.Distance(transform.position, target.transform.position)<30)
            {
                anim.SetBool("walk", false);
                yield return StartCoroutine(Lunge());

            }
        }
    }

    IEnumerator Lunge()
    {
        while(true)
        {
            yield return null;

            if (target == null)
            {
                Start();
                break;
            }

            if (target.facehugged == true)
            {
                break;
            }

            if(target.carcass == true)
            {
                anim.SetBool("run", false);
                break;
            }

            anim.SetBool("run", true);
            lookdirection = target.transform.position - transform.position;
            look = Quaternion.LookRotation(lookdirection);
            look = Quaternion.Slerp(transform.rotation, look, speed * Time.deltaTime);
            //look = Quaternion.Slerp(look, transform.rotation, speed*Time.deltaTime);
            transform.rotation = look;

            velocity = (transform.forward * run_speed) + (-transform.up * gravity);
            controller.Move(velocity * Time.deltaTime);

            if (Vector3.Distance(transform.position, target.transform.position)<attack_distance)
            {
                anim.SetBool("run", false);
                yield return StartCoroutine(Attack());
            }
        }
    }

    IEnumerator Attack()
    {
        while(true)
        {
            yield return null;

            if (target == null)
            {
                anim.SetBool("attack", false);
                Start();
                break;
            }

            if (target.facehugged == true)
            {
                break;
            }
            
            if(target.carcass == true)
            {
                anim.SetBool("attack", false);
                break;
            }
            anim.SetBool("attack", true);
            target.GetComponent<Human>().hp -= rate_of_attack;

            
            if(target.GetComponent<Human>().hp <=0)
            {
                anim.SetBool("attack", false);
                yield return StartCoroutine(CheckTarget());
            } 
            
            /*
            if(Vector3.Distance(transform.position, target.transform.position) > attack_distance)
            {
                anim.SetBool("attack", false);
            }
            */
            //transform.position = target.transform.position - transform.position;
        }
    }
}