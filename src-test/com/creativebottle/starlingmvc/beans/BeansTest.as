package com.creativebottle.starlingmvc.beans
{
	import com.creativebottle.starlingmvc.mock.model.TestModel;
	import com.creativebottle.starlingmvc.mock.model.TestModel2;

	import org.flexunit.asserts.assertEquals;
	import org.flexunit.asserts.assertNull;

	public class BeansTest
	{
		private var beans:Beans;

		[Before]
		public function setup():void
		{
			beans = new Beans();
		}

		[After]
		public function teardown():void
		{
			beans = null;
		}

		[Test]
		public function addBean_beanWithNoIdRetrievableByType_returnsBean():void
		{
			var beanIn:Bean = new Bean(new TestModel());

			beans.addBean(beanIn);

			var beanOut:Bean = beans.getBeanByClass(TestModel);

			assertEquals("Beans should be equal.", beanIn, beanOut);
		}

		public function addBean_beanWithIdRetrievableById_returnsBean():void
		{
			var beanIn:Bean = new Bean(new TestModel(), "testBean");

			beans.addBean(beanIn);

			var beanOut:Bean = beans.getBeanById("testBean");

			assertEquals("Beans should be equal.", beanIn, beanOut);
		}

		[Test]
		public function addBean_beanWithNoIdNotRetrievableById_returnsNull():void
		{
			var beanIn:Bean = new Bean(new TestModel());

			beans.addBean(beanIn);

			var beanOut:Bean = beans.getBeanById("testBean");

			assertNull("Bean should be null.", beanOut);
		}

		[Test]
		public function addBean_beanWithIdNotRetrievableByType_returnsNull():void
		{
			var beanIn:Bean = new Bean(new TestModel(), "testBean");

			beans.addBean(beanIn);

			var beanOut:Bean = beans.getBeanByClass(TestModel);

			assertNull("Bean should be null.", beanOut);
		}

		[Test]
		public function addBean_nonBean_returnsBeanWithObjectAsInstance():void
		{
			var beanIn:TestModel = new TestModel();

			beans.addBean(beanIn);

			var beanOut:Bean = beans.getBeanByClass(TestModel);

			assertEquals("Bean instance should equal beanIn.", beanIn, beanOut.instance);
		}

		[Test]
		public function addBeans_returnsBeans():void
		{
			var b:Array = [new TestModel(), new TestModel2()];

			beans.addBeans(b);

			var beanOut:Bean = beans.getBeanByClass(TestModel2);

			assertEquals("beanOut.instance should equal the second object in the array.", b[1], beanOut.instance);
		}

		[Test]
		public function removeBean_beanWithId_returnsNull():void
		{
			var beanIn:Bean = new Bean(new TestModel(), "testBean");

			beans.addBean(beanIn);
			beans.removeBean(beanIn);

			var beanOut:Bean = beans.getBeanById("testBean");

			assertNull("Bean should be null.", beanOut);
		}

		[Test]
		public function removeBean_beanWithNoId_returnsNull():void
		{
			var beanIn:Bean = new Bean(new TestModel());

			beans.addBean(beanIn);
			beans.removeBean(beanIn);

			var beanOut:Bean = beans.getBeanByClass(TestModel);

			assertNull("Bean should be null.", beanOut);
		}

		[Test]
		public function addBeanProvider_mixedBeans_retrieveByType_returnsBean():void
		{
			var beanProvider:BeanProvider = new BeanProvider();
			beanProvider.beans = [new TestModel(), new Bean(new TestModel2(), "testModel2")];

			beans.addBeanProvider(beanProvider);

			var beanOut:Bean = beans.getBeanByClass(TestModel);

			assertEquals("Method should return first bean in the provider.", beanProvider.beans[0], beanOut.instance);
		}

		[Test]
		public function addBeanProvider_mixedBeans_retrieveById_returnsBean():void
		{
			var beanProvider:BeanProvider = new BeanProvider();
			beanProvider.beans = [new TestModel(), new Bean(new TestModel2(), "testModel2")];

			beans.addBeanProvider(beanProvider);

			var beanOut:Bean = beans.getBeanById("testModel2");

			assertEquals("Method should return first bean in the provider.", beanProvider.beans[1], beanOut);
		}

	}
}