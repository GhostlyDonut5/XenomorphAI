using UnityEngine;
using System.Collections;
using System.Collections.Generic;

public class Facehugger : MonoBehaviour 
{
    FacehuggerManager facehugger_man;
    public CharacterController controller;
    public GameObject head;
    public Human target;
    Quaternion look;
    public Vector3 velocity;
    public float speed;
    public float gravity;
    public float current_timer;
    public float jump_timer;
    public float facehug_timer;
    public float jump_force;
    public float jump_speed;
    public float distance_before_jump;
    public float distance_before_crawl;
    public float distance_before_facehug;
    public float crawl_speed;
    public bool jumped;
    Vector3 lookdirection;

    void Awake()
    {
        facehugger_man = FacehuggerManager.Instance;
    }


    void Start()
    {
        velocity = Vector3.zero;
        StartCoroutine(CheckTarget());
    }

    public IEnumerator CheckTarget()
    {
        while(true)
        {
            yield return null;
            facehugger_man.GetTarget(this);

            if(target!=null)
            {
                if (!target.facehugged)
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
                //yield return StartCoroutine(Walk());
                break;
            }
        }
    }

    public IEnumerator Run()
    {
        while (true)
        {
            yield return null;
            if (target == null)
            {
                Start();
                break;
            }

            if (target.facehugged)
            {
                break;
            }


            //animation.Play();

            velocity = (transform.forward * speed) + (-transform.up * gravity);

            controller.Move(velocity*Time.deltaTime);
            lookdirection = target.transform.position - transform.position;
            lookdirection.y = 0;
            look = Quaternion.LookRotation(lookdirection);
            look = Quaternion.Slerp(transform.rotation, look, speed * Time.deltaTime);
            transform.rotation = look;
            
            if(jumped == true)
            {
                current_timer -= Time.deltaTime;
                if(current_timer<=0)
                {
                    jumped = false;
                }
            }

            if (Vector3.Distance(transform.position, target.transform.position) < distance_before_jump)
            {
                if (target.GetComponent<Human>().facehugged == false)
                {
                    if(jumped == false)
                    {
                        yield return StartCoroutine(Jump());
                    }
                }
            }


            if(Vector3.Distance(transform.position, target.transform.position) < distance_before_crawl)
            {
                if(target.GetComponent<Human>().facehugged == false)
                {
                    if(jumped == false)
                    {
                        yield return StartCoroutine(Crawl());
                    }
                }
            }
        }
    }

    IEnumerator Crawl()
    {
        while(true)
        {
            yield return null;

            if (target == null)
            {
                Start();
                break;
            }

            if (target.facehugged)
            {
                break;
            }


            //animation.Play();
            float distance = 0;
            distance = Vector3.Distance(transform.position, head.transform.position);
            velocity = (transform.forward * crawl_speed);

            controller.Move(velocity * Time.deltaTime);
            lookdirection = target.transform.Find("Head").gameObject.transform.position - transform.position;
            //lookdirection.y = 0;
            look = Quaternion.LookRotation(lookdirection);
            look = Quaternion.Slerp(transform.rotation, look, crawl_speed * Time.deltaTime);
            transform.rotation = look;

            if(distance < head.transform.localScale.x + transform.localScale.x && target.GetComponent<Human>().facehugged == false)
            {
                yield return StartCoroutine(Facehug());
            }
            


        }
    }
    IEnumerator Jump()
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

            velocity = (transform.up * jump_force) + (transform.forward * speed*jump_speed);
            controller.Move(velocity * Time.deltaTime);
            transform.rotation = look;
            current_timer = jump_timer;
            jumped = true;
            GetComponent<AudioSource>().Play();
            //animation.Play();
            //facehug.PlayOneShot(facehugging);
            
            yield return StartCoroutine(Jumping());

        }
    }

    IEnumerator Jumping()
    {
        while(true)
        {
            yield return null;

            if(target == null)
            {
                Start();
                break;
            }

            if(target.facehugged == true)
            {
                break;
            }

           
            float distance = 0;
            GameObject head;
            head = target.transform.Find("Head").gameObject;
            distance = Vector3.Distance(transform.position, head.transform.position);
            velocity -= transform.up*gravity;
            controller.Move(velocity * Time.deltaTime);

            if(controller.isGrounded)
            {
                if (Vector3.Distance(transform.position, target.transform.position) < distance_before_crawl)
                {
                    if (target.GetComponent<Human>().facehugged == false)
                    {
                            yield return StartCoroutine("Crawl");
                    }
                }

                else
                {
                    yield return StartCoroutine(CheckTarget());
                }
            }

            else if (distance < head.transform.localScale.x + transform.localScale.x && target.GetComponent<Human>().facehugged == false 
                || distance < distance_before_facehug && target.GetComponent<Human>().facehugged == false)
            {
                yield return StartCoroutine(Facehug());
            }
        }
    }

    IEnumerator Facehug()
    {
        while (true)
        {
            yield return null;
            //Vector3 center;

            transform.parent = target.transform;
            transform.position = target.transform.Find("Head").transform.position
                                    + target.transform.Find("Head").forward
                                    * (target.transform.Find("Head").transform.localScale.x + transform.localScale.x);
            
            target.GetComponent<Human>().facehugged = true;
            current_timer = facehug_timer;
            yield return StartCoroutine(Die());
        }
    }


    IEnumerator Walk()
    {
        while (true)
        {
            yield return null;
                    
            velocity = (transform.forward * speed) + (-transform.up * gravity);
            controller.Move(velocity * Time.deltaTime);

            if (target == null)
            {
                Debug.Log("Walking");
                yield return StartCoroutine(CheckTarget());
            }
        }
    }


    IEnumerator Die()
    {
        while (true)
        {
            yield return null;

            current_timer -= Time.deltaTime;
            if (current_timer <= 0)
            {
                Destroy(gameObject);
                target.GetComponent<Human>().impregnated = true;
                facehugger_man.RemoveFaceHugger(this);
                //animation.Play();
            }
        }
    }
}