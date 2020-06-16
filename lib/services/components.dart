import 'package:flutter/material.dart';
import 'package:aptus/services/constants.dart';

class OurRoundedButton extends StatelessWidget {
  OurRoundedButton({this.title, this.colour, @required this.onPressed});

  final Color colour;
  final String title;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 1.0,
        color: colour,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: onPressed,
          minWidth: 100.0,
          height: 42.0,
          child: Text(
            title,
            style: TextStyle(

                fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

class OurRoundedButtonLarge extends StatelessWidget {
  OurRoundedButtonLarge({this.title, this.colour, @required this.onPressed});

  final Color colour;
  final String title;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 1.0,
        color: colour,
        borderRadius: BorderRadius.circular(15.0),
        child: MaterialButton(
          onPressed: onPressed,
          minWidth: 270.0,
          height: 42.0,
          child: Text(
            title,
            style: TextStyle(
              fontFamily: 'DM Sans',
              fontSize: 15.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

class OurReusableCard extends StatelessWidget {
  OurReusableCard({@required this.colour, this.cardChild, this.onPress});

  final Color colour;
  final Widget cardChild;
  final Function onPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        child: cardChild,
        margin: EdgeInsets.all(5.0),
        decoration: BoxDecoration(
          color: colour,
          borderRadius: BorderRadius.circular(50.0),
        ),
      ),
    );
  }
}

class OurIconContent extends StatelessWidget {
  OurIconContent({
    this.icon,
    this.label,
  });

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          icon,
          size: 20.0,
        ),
        SizedBox(
          height: 15.0,
        ),
        Text(
          label,
          style: kLabelTextStyle,
        )
      ],
    );
  }
}

class OurRoundIconButton extends StatelessWidget {
  OurRoundIconButton(
      {@required this.icon, @required this.onPressed, this.colour});

  final IconData icon;
  final Function onPressed;
  final Color colour;
  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      elevation: 0.0,
      child: Icon(icon),
      onPressed: onPressed,
      constraints: BoxConstraints.tightFor(
        width: 45.0,
        height: 45.0,
      ),
      shape: CircleBorder(),
      fillColor: colour,
    );
  }
}

class OurBottomButton extends StatelessWidget {
  OurBottomButton({@required this.onTap, @required this.buttonTitle});

  final Function onTap;
  final String buttonTitle;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        child: Center(
          child: Text(
            buttonTitle,
            style: kLargeButtonTextStyle,
          ),
        ),
        color: kBottomContainerColour,
        margin: EdgeInsets.only(top: 10.0),
        padding: EdgeInsets.only(bottom: 20.0),
        width: double.infinity,
        height: kBottomContainerHeight,
      ),
    );
  }
}

class OurContainer extends StatelessWidget {

  final Widget child;

  const OurContainer({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 10.0,
            spreadRadius: 1.0,
            offset: Offset(
              4.0,
              4.0,
            ),
          )
        ],
      ),
      child: child,
    );
  }
}


class OurContainerOpaque extends StatelessWidget {
  final Widget child;

  const OurContainerOpaque({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(

      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 10.0,
            spreadRadius: 1.0,
          )
        ],
      ),
      child: child,
    );
  }
}