package picka.service;

import java.net.InetSocketAddress;
import java.net.Proxy;
import java.net.URL;
import java.net.URLConnection;
import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;
import java.util.Queue;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

@Service
public class AreaSearchListService {
	
	private final Logger logger = Logger.getLogger(this.getClass());
	
	//api key(새로생성 2015.07.29) justkook@naver.com
//	private final String API_KEY = "&key=2bd772f4f933decb86b04e99137bc09e";
	private final String API_KEY = "&key=527401d03af05564d587050dd5cc08f1"; //서버용
	
	public List<String> getList(String area) throws Exception {
		
		List<String> returnList = new ArrayList<String>();
		
		if(area!=null && !"".equals(area)){
			//예) https://maps.googleapis.com/maps/api/place/autocomplete/xml?input=%EA%B0%95%EB%82%A8&types=geocode&key=AIzaSyBrIM2s64s3rK6eqptDr1rb8qzA0lSgC4o
			String apiUrl = "http://openapi.map.naver.com/api/geocode?"
					+ API_KEY //지역 : url에서는 공백을 %20으로 표현
					+ "&encoding=utf-8&coord=latlng&output=xml&query=" //지역코드(&types=geocode), 한국에서
					+ area.replace(" ", "%20");
			logger.info("api_url="+apiUrl);
			
			//reading xml data
			DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
			DocumentBuilder builder = factory.newDocumentBuilder();
			
			URL urlInfo = new URL(apiUrl);
			Proxy proxy = new Proxy(Proxy.Type.HTTP, new InetSocketAddress("70.10.15.10", 8080)); //내부망 proxy server
			URLConnection con = urlInfo.openConnection(proxy); //proxy 설정으로 connection 열기
			Document document = builder.parse(con.getInputStream());
			
			document.getDocumentElement().normalize();
			
			NodeList pointNodeList = document.getElementsByTagName("point");
			int pCount = pointNodeList.getLength();
			Queue<String> xyQueue = new LinkedList<String>();
			findXyNode(pointNodeList, pCount, xyQueue);
			
			NodeList adrNodeList = document.getElementsByTagName("address");
			int count = adrNodeList.getLength();
			logger.info("adrNodeList.getLength()="+count);
			for(int i=0; i<count; i++){
				Node node = adrNodeList.item(i);
				if(node.getNodeType()==Node.ELEMENT_NODE){
					logger.info("nodeName="+node.getNodeName()+", textConete="+node.getTextContent());
					returnList.add(node.getTextContent());
					returnList.add(xyQueue.poll());
					returnList.add(xyQueue.poll());
				}
			}
		}
		if(logger.isInfoEnabled()){
			logger.info("Before return, check returnList");
			for(String data : returnList){
				logger.info(data);
			}
		}
		return returnList;
    }
	
	private void findXyNode(NodeList nodeList, int count, Queue<String> xyQueue){
		for(int i=0; i<count; i++){
			Node node = nodeList.item(i);
			if(node.getNodeType()==Node.ELEMENT_NODE){
				Element element = (Element) node;
				if(element.hasChildNodes()){
					NodeList childNodeList = element.getElementsByTagName("*");
					int childLength = childNodeList.getLength();
					findXyNode(childNodeList, childLength, xyQueue);
				}
				if( "x".equals(node.getNodeName()) || "y".equals(node.getNodeName()) ){
					logger.info("nodeName="+node.getNodeName()+", textConete="+node.getTextContent());
					xyQueue.offer(node.getTextContent());
				}
				
			}
		}
	}
	
}
