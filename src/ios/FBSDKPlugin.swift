import Foundation

@objc(FBSDKPlugin)
public class FBSDKPlugin : CDVPlugin {
    
  var cpConnector = cpConnectionService()
    
  @objc
  func initialize(_ command: CDVInvokedUrlCommand) {
    let token = command.argument(at: 0) as! String?
    let CPToken = command.argument(at: 1) as! String?
    let CPGroupName = command.argument(at: 2) as! String?
    let CPName = command.argument(at: 3) as! String?
    self.cpConnector.initWithOptions(appscptoken:CPToken, appscpgroup:CPGroupName, appscpname: CPName, doPostCartScreenshot: "", isFIRAlreadyInc: "" )
    self.cpConnector.postFCMTokenToCP(fcmToken: token!)
    cpMainParameters.shared.isPushActive = true
    let pluginResult = CDVPluginResult.init(status: CDVCommandStatus_OK, messageAs: "OK")
    self.commandDelegate.send(pluginResult, callbackId: command.callbackId)
  }

    @objc
    func doPostToken(_ command: CDVInvokedUrlCommand) {
        let token = command.argument(at: 0) as! String?
        self.cpConnector.resetcurSessionFCMTokenPosted(newValue: "no")
        self.cpConnector.postFCMTokenToCP(fcmToken: token!)
        let pluginResult = CDVPluginResult.init(status: CDVCommandStatus_OK, messageAs: "OK")
        self.commandDelegate.send(pluginResult, callbackId: command.callbackId)
    }

    @objc
    func pageView(_ command: CDVInvokedUrlCommand) {
        let utmdt = command.argument(at: 0) as! String?
        let utmp = command.argument(at: 1) as! String?
        self.cpConnector.pageView(utmdt: utmdt, utmp: utmp)
        let pluginResult = CDVPluginResult.init(status: CDVCommandStatus_OK, messageAs: "OK")
        self.commandDelegate.send(pluginResult, callbackId: command.callbackId)
    }

    @objc
    func productView(_ command: CDVInvokedUrlCommand) {
        let pName = command.argument(at: 0) as! String?
        let pSku = command.argument(at: 1) as! String?
        let utmp = command.argument(at: 2) as! String?
        self.cpConnector.productView(pName: pName, pSku: pSku, utmp: utmp)
        let pluginResult = CDVPluginResult.init(status: CDVCommandStatus_OK, messageAs: "OK")
        self.commandDelegate.send(pluginResult, callbackId: command.callbackId)
    }

    @objc
    func add2Cart(_ command: CDVInvokedUrlCommand) {
        let pName = command.argument(at: 0) as! String?
        let pSku = command.argument(at: 1) as! String?
        let pQty = command.argument(at: 2) as! Int?
        let pUnitPrice = command.argument(at: 3) as! Double?
        let utmp = command.argument(at: 4) as! String?
        let pimg = command.argument(at: 5) as! String?
        self.cpConnector.add2cart(pName: pName, pSku: pSku, pQty: pQty, pUnitPrice: pUnitPrice, pImgURL: pimg, utmp: utmp)
        let pluginResult = CDVPluginResult.init(status: CDVCommandStatus_OK, messageAs: "OK")
        self.commandDelegate.send(pluginResult, callbackId: command.callbackId)
    }
    
    @objc
    func removeFromCart(_ command: CDVInvokedUrlCommand) {
        let pName = command.argument(at: 0) as! String?
        let pSku = command.argument(at: 1) as! String?
        let pQty = command.argument(at: 2) as! Int?
        let pUnitPrice = command.argument(at: 3) as! Double?
        let utmp = command.argument(at: 4) as! String?
        let pimg = command.argument(at: 5) as! String?
        self.cpConnector.removefromcart(pName: pName, pSku: pSku, pQty: pQty, pUnitPrice: pUnitPrice, pImgURL: pimg, utmp: utmp)
        let pluginResult = CDVPluginResult.init(status: CDVCommandStatus_OK, messageAs: "OK")
        self.commandDelegate.send(pluginResult, callbackId: command.callbackId)
    }

    @objc
    func setOrderData(_ command: CDVInvokedUrlCommand) {
        let oId = command.argument(at: 0) as! String?
        let oValue = command.argument(at: 1) as! Double?
        self.cpConnector.setOrderData(oId:oId, oValue:oValue)
        let pluginResult = CDVPluginResult.init(status: CDVCommandStatus_OK, messageAs: "OK")
        self.commandDelegate.send(pluginResult, callbackId: command.callbackId)
    }

    @objc
    func addOrderItem(_ command: CDVInvokedUrlCommand) {
        let sku = command.argument(at: 0) as! String?
        let name = command.argument(at: 1) as! String?
        let quant = command.argument(at: 2) as! Int?
        let price = command.argument(at: 3) as! Double?
        self.cpConnector.addOrderItem(sku:sku, name:name, quant: quant, price:price)
        let pluginResult = CDVPluginResult.init(status: CDVCommandStatus_OK, messageAs: "OK")
        self.commandDelegate.send(pluginResult, callbackId: command.callbackId)
    }
    
    
    @objc
    func placeOrder(_ command: CDVInvokedUrlCommand) {
        let utmp = command.argument(at: 0) as! String?
        self.cpConnector.postOrder(utmp: utmp)
        let pluginResult = CDVPluginResult.init(status: CDVCommandStatus_OK, messageAs: "OK")
        self.commandDelegate.send(pluginResult, callbackId: command.callbackId)
    }
    
    @objc
    func postCart(_ command: CDVInvokedUrlCommand) {
        self.cpConnector.postCart()
        let pluginResult = CDVPluginResult.init(status: CDVCommandStatus_OK, messageAs: "OK")
        self.commandDelegate.send(pluginResult, callbackId: command.callbackId)
    }

    @objc
    func postCustomCart(_ command: CDVInvokedUrlCommand) {
        let cartItems = command.argument(at: 0) as! [AnyHashable: Any]?
        var curCartItems = [cpCartItem]()
        self.cpConnector.postCustomCart(cartItems: curCartItems)
        let pluginResult = CDVPluginResult.init(status: CDVCommandStatus_OK, messageAs: "OK")
        self.commandDelegate.send(pluginResult, callbackId: command.callbackId)
    }
    
    @objc
    func postContactEmail(_ command: CDVInvokedUrlCommand) {
        let cp_curEmail = "test@test.gr"
        let utmp = "/myiosapp/category/subcategory/mypage/"
        self.cpConnector.setContactMail(eMail: cp_curEmail, utmp: utmp)
        let pluginResult = CDVPluginResult.init(status: CDVCommandStatus_OK, messageAs: "OK")
        self.commandDelegate.send(pluginResult, callbackId: command.callbackId)
    }

}
