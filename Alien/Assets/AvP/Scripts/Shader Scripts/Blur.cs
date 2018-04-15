using UnityEngine;
using System.Collections;

public class Blur : MonoBehaviour 
{

	public Material mat;
	public float numPasses;
	public float spacing = 0.01f;
	public float rate = 3.14f; //rad/s
	float angle;

	void Update()
	{
		angle += rate * Time.deltaTime;
	}

	void OnRenderImage(RenderTexture src, RenderTexture dest)
	{
		RenderTexture t1 = RenderTexture.GetTemporary (src.width, src.height, src.depth, src.format, RenderTextureReadWrite.Linear);

		//temp.filterMode = FilterMode.Bilinear;

		//mat.SetFloat ("_XSpacing", spacing*Mathf.Cos (angle));
		//mat.SetFloat ("_YSpacing", spacing*Mathf.Sin (angle));
		Graphics.Blit (src, t1);

		for(int i = 0; i<numPasses; i++)
		{
			RenderTexture t2 = RenderTexture.GetTemporary (src.width, src.height, src.depth, src.format, RenderTextureReadWrite.Linear);
			Graphics.Blit(t1, t2, mat);
			RenderTexture.ReleaseTemporary (t1);
			t1 = t2;
		}

		Graphics.Blit (t1, dest);

		RenderTexture.ReleaseTemporary (t1);
	}

}
