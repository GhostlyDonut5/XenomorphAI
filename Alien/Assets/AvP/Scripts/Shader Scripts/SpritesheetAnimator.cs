using UnityEngine;
using System.Collections;

public class SpritesheetAnimator : MonoBehaviour 
{

    public float framerate = 8;
    public float numcol = 1;
    public float numrow = 1;
    public bool pingpong = false;
    public int numframes;
    public Texture2D img;

    float timer = 0;
    int frame = 0;
    int sign = 1;
	// Use this for initialization
	void Start ()
    {
        Vector4 dim = new Vector4 (numcol, numrow, 0,0);
        GetComponent<Renderer>().material.SetTexture ("_MainTex", img);
        GetComponent<Renderer>().material.SetVector("_Dimensions", dim);
        GetComponent<Renderer>().material.SetInt("_Frame", 0);

        timer = 1 / framerate;

        if(numframes == 0)
        {
            numframes = (int)(numcol * numrow);
        }
	}
	
	// Update is called once per frame
	void Update () 
    {
        timer -= Time.deltaTime;
        if(timer <=0)
        {
            timer = 1 / framerate;
            ++frame;
            if(!pingpong)
            {
                ++frame;
                frame %= numframes;
            }
            else
            {
                if(frame >= numframes)
                {
                    frame--;
                    sign = -1;
                }
                else if(frame <0)
                {
                    frame++;
                    sign = 1;
                }
            }

            //print(frame);
            GetComponent<Renderer>().material.SetInt("_Frame", ++frame);
        }
	}
}
