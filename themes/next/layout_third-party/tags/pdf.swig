{%- if theme.pdf.enable %}
<script{{ pjax }}>
var pdfobjectversion = "2.1.1", ua = window.navigator.userAgent, supportsPDFs, isIE, supportsPdfMimeType = (typeof navigator.mimeTypes['application/pdf'] !== "undefined"), supportsPdfActiveX, isModernBrowser = (function() {
	return (typeof window.Promise !== "undefined");
}
)(), isFirefox = (function() {
	return (ua.indexOf("irefox") !== -1);
}
)(), isFirefoxWithPDFJS = (function() {
	if (!isFirefox) {
		return false;
	}
	return (parseInt(ua.split("rv:")[1].split(".")[0], 10) > 18);
}
)(), isIOS = (function() {
	return (/iphone|ipad|ipod/i.test(ua.toLowerCase()));
}
)(), createAXO, buildFragmentString, log, embedError, embed, getTargetElement, generatePDFJSiframe, generateEmbedElement;
function createAXO(type) {
	var ax;
	try {
		ax = new ActiveXObject(type);
	} catch (e) {
		ax = null;
	}
	return ax;
};
//IsPC() true为PC端，false为手机端
function IsPC() {
    var userAgentInfo = navigator.userAgent;
    var Agents = ["Android", "iPhone",
                "SymbianOS", "Windows Phone",
                "iPad", "iPod"];
    var flag = true;
    for (var v = 0; v < Agents.length; v++) {
        if (userAgentInfo.indexOf(Agents[v]) > 0) {
            flag = false;
            break;
        }
    }
    return flag;
};
function isIE() {
	return !!(window.ActiveXObject || "ActiveXObject"in window);
}
;
function supportsPdfActiveX() {
	return !!(createAXO("AcroPDF.PDF") || createAXO("PDF.PdfCtrl"));
}
;
supportsPDFs = (!isIOS && (isFirefoxWithPDFJS || supportsPdfMimeType || (isIE() && supportsPdfActiveX())));
function buildFragmentString(pdfParams) {
	var string = "", prop;
	if (pdfParams) {
		for (prop in pdfParams) {
			if (pdfParams.hasOwnProperty(prop)) {
				string += encodeURIComponent(prop) + "=" + encodeURIComponent(pdfParams[prop]) + "&";
			}
		}
		if (string) {
			string = "#" + string;
			string = string.slice(0, string.length - 1);
		}
	}
	return string;
};
function log(msg) {
	if (typeof console !== "undefined" && console.log) {
		console.log("[PDFObject] " + msg);
	}
};
function embedError(msg) {
	log(msg);
	return false;
};
function getTargetElement(targetSelector) {
	var targetNode = document.body;
	if (typeof targetSelector === "string") {
		targetNode = document.querySelector(targetSelector);
	} else if (typeof jQuery !== "undefined" && targetSelector instanceof jQuery && targetSelector.length) {
		targetNode = targetSelector.get(0);
	} else if (typeof targetSelector.nodeType !== "undefined" && targetSelector.nodeType === 1) {
		targetNode = targetSelector;
	}
	return targetNode;
};
function generatePDFJSiframe(targetNode, url, pdfOpenFragment, PDFJS_URL, id) {
	var fullURL = PDFJS_URL + "?file=" + encodeURIComponent(url) + pdfOpenFragment;
	var scrollfix = (isIOS) ? "-webkit-overflow-scrolling: touch; overflow-y: scroll; " : "overflow: hidden; ";
	var iframe = "<div style='" + scrollfix + "position: absolute; top: 0; right: 0; bottom: 0; left: 0;'><iframe  " + id + " src='" + fullURL + "' style='border: none; width: 100%; height: 100%;' frameborder='0'></iframe></div>";
	targetNode.className += " pdfobject-container";
	targetNode.style.position = "relative";
	targetNode.style.overflow = "auto";
	targetNode.innerHTML = iframe;
	return targetNode.getElementsByTagName("iframe")[0];
};
function generateEmbedElement(targetNode, targetSelector, url, pdfOpenFragment, width, height, id) {
	var style = "";
	if (targetSelector && targetSelector !== document.body) {
		style = "width: " + width + "; height: " + height + ";";
	} else {
		style = "position: absolute; top: 0; right: 0; bottom: 0; left: 0; width: 100%; height: 100%;";
	}
	targetNode.className += " pdfobject-container";
	targetNode.innerHTML = "<embed " + id + " class='pdfobject' src='" + url + pdfOpenFragment + "' type='application/pdf' style='overflow: auto; " + style + "'/>";
	return targetNode.getElementsByTagName("embed")[0];
};
function embed(url, targetSelector, options) {
	if (typeof url !== "string") {
		return embedError("URL is not valid");
	}
	targetSelector = (typeof targetSelector !== "undefined") ? targetSelector : false;
	options = (typeof options !== "undefined") ? options : {};
	var id = (options.id && typeof options.id === "string") ? "id='" + options.id + "'" : ""
	  , page = (options.page) ? options.page : false
	  , pdfOpenParams = (options.pdfOpenParams) ? options.pdfOpenParams : {}
	  , fallbackLink = (typeof options.fallbackLink !== "undefined") ? options.fallbackLink : true
	  , width = (options.width) ? options.width : "100%"
	  , height = (options.height) ? options.height : "100%"
	  , assumptionMode = (typeof options.assumptionMode === "boolean") ? options.assumptionMode : true
	  , forcePDFJS = (typeof options.forcePDFJS === "boolean") ? options.forcePDFJS : false
	  , PDFJS_URL = (options.PDFJS_URL) ? options.PDFJS_URL : false
	  , targetNode = getTargetElement(targetSelector)
	  , fallbackHTML = ""
	  , pdfOpenFragment = ""
	  , fallbackHTML_default = "<p>This browser does not support inline PDFs. Please download the PDF to view it: <a href='[url]'>Download PDF</a></p>";
	if (!targetNode) {
		return embedError("Target element cannot be determined");
	}
	if (page) {
		pdfOpenParams.page = page;
	}
	pdfOpenFragment = buildFragmentString(pdfOpenParams);
	if (forcePDFJS && PDFJS_URL) {
		return generatePDFJSiframe(targetNode, url, pdfOpenFragment, PDFJS_URL, id);
	} else if (IsPC()&&(supportsPDFs || (assumptionMode && isModernBrowser && !isIOS))) {
		return generateEmbedElement(targetNode, targetSelector, url, pdfOpenFragment, width, height, id);
	} else if (PDFJS_URL) {
		return generatePDFJSiframe(targetNode, url, pdfOpenFragment, PDFJS_URL, id);
	} else {
		if (fallbackLink) {
			fallbackHTML = (typeof fallbackLink === "string") ? fallbackLink : fallbackHTML_default;
			targetNode.innerHTML = fallbackHTML.replace(/\[url\]/g, url);
		}
		return embedError("This browser does not support embedded PDFs");
	}
}
if (document.querySelectorAll('div.pdf').length) {
    document.querySelectorAll('div.pdf').forEach(element => {
      embed(element.getAttribute('target'), element, {
        pdfOpenParams: {
          navpanes: 0,
          toolbar: 0,
          statusbar: 0,
          pagemode: 'thumbs',
          view: 'FitH'
        },
        PDFJS_URL: '/lib/pdf/web/viewer.html',
        height: element.getAttribute('height') || '{{ theme.pdf.height }}'
      });
    });
}
</script>
{%- endif %}